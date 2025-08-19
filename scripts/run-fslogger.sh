#!/usr/bin/env bash
set -euo pipefail
LOG_DIR="${1:-.logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/fswatch.log"
command -v fswatch >/dev/null 2>&1 || { echo "Install fswatch (macOS: brew install fswatch)"; exit 1; }
echo "Logging changes to $LOG_FILE (Ctrl-C to stop)…"
fswatch -r -e '\.git' -e '\.logs' . | while read -r path; do
  printf "%s %s\n" "$(date +'%Y-%m-%d %H:%M:%S %z')" "$path" >> "$LOG_FILE"
done
