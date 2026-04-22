#!/usr/bin/env bash
# Well-formed XML check for Kodi skin files (catches typos, unclosed tags, bad entities).
# Does not validate Kodi-specific semantics — only structure.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_one() {
  local f="$1"
  if command -v xmllint >/dev/null 2>&1; then
    xmllint --noout "$f"
  else
    python3 -c 'import xml.etree.ElementTree as ET; import sys; ET.parse(sys.argv[1])' "$f"
  fi
}

ERR=0
while IFS= read -r -d '' f; do
  if ! check_one "$f" 2>/dev/null; then
    echo "Invalid XML: $f" >&2
    check_one "$f" >&2 || true
    ERR=1
  fi
done < <(find "$ROOT/1080i" -name '*.xml' -print0)
exit "$ERR"
