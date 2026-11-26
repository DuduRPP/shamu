"""Check inline links to files in the repository's tracked template documentation."""

import os
import re
import subprocess
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parent.parent
DOC_PATHS = ("AGENTS.md", "README.md", ".agents/skills", "docs", "templates")
LINK = re.compile(r"\]\((?:<([^>]+)>|([^\s()]+))(?:\s+['\"].*?['\"])?\)")
FENCE = re.compile(r"^\s*(`{3,}|~{3,})(.*)$")
CODE = re.compile(r"`+[^`\n]*`+")
COMMENT = re.compile(r"<!--.*?-->", re.DOTALL)
EXTERNAL = re.compile(r"^(?:[a-z][a-z0-9+.-]*:|//)", re.IGNORECASE)


def local_links(markdown):
    fence = ""
    visible = COMMENT.sub(lambda match: "\n" * match[0].count("\n"), markdown)
    for number, line in enumerate(visible.splitlines(), 1):
        marker = FENCE.match(line)
        if marker:
            delimiter, suffix = marker.groups()
            if not fence:
                fence = delimiter
            elif delimiter.startswith(fence) and not suffix.strip():
                fence = ""
            continue
        if fence:
            continue
        for angle_target, bare_target in LINK.findall(CODE.sub("", line)):
            target = angle_target or bare_target
            if not EXTERNAL.match(target):
                path = unquote(target.split("#", 1)[0].split("?", 1)[0])
                if path:
                    yield number, path


def main():
    tracked = subprocess.check_output(["git", "ls-files", "-z", "--", *DOC_PATHS], cwd=ROOT)
    missing = 0
    for name in os.fsdecode(tracked).split("\0"):
        source = ROOT / name
        if source.suffix.lower() != ".md":
            continue
        for line, link in local_links(source.read_text(encoding="utf-8-sig")):
            target = (ROOT / link[1:] if link.startswith("/") else source.parent / link).resolve()
            if not target.is_relative_to(ROOT) or not target.exists():
                print(f"{name}:{line}: unresolved repository link {link}")
                missing += 1
    if not missing:
        print("Local Markdown links passed.")
    return int(missing > 0)


if __name__ == "__main__":
    raise SystemExit(main())
