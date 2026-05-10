#!/bin/bash
# Double-click this file to launch the Lotus pond locally.
# It starts a tiny web server in this folder, then opens it in your browser.
# Close this terminal window (or press Ctrl+C) to stop.

cd "$(dirname "$0")"

PORT=8000
while lsof -i ":$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; do
  PORT=$((PORT+1))
done

URL="http://localhost:$PORT"
echo ""
echo "  ──────────────────────────────────────────"
echo "   一池莲柳 · serving at $URL"
echo "   close this window (or press Ctrl+C) to stop"
echo "  ──────────────────────────────────────────"
echo ""

(sleep 1 && open "$URL") &

# python3 ships with macOS; falls back to python if needed
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server "$PORT"
else
  python -m http.server "$PORT"
fi
