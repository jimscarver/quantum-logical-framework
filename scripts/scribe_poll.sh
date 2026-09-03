#!/usr/bin/env bash
# scribe_poll.sh — connect to the quantum-os room, pull `/scribe list 500`,
# print only transcript lines not seen on a previous run. Flags lines aimed at
# the Claude CLI (claude / cli / task / test / lemma). Session-cron helper.
#
# Usage: scripts/scribe_poll.sh
# State: scratchpad/scribe_seen.txt  (one transcript line per row, deduped)

set -u
ROOM="cap:room:05214747236101414325074505234721"
CLI_DIR="$HOME/quantum-os/scripts/qos-cli"
STATE_DIR="/tmp/claude-1000/-home-jimscarver-quantum-logical-framework/7cbbf27c-8b68-4ebc-8703-e77936ef20f2/scratchpad"
SEEN="$STATE_DIR/scribe_seen.txt"
LOG="$STATE_DIR/scribe_poll_$(date +%s).log"
mkdir -p "$STATE_DIR"; touch "$SEEN"

cd "$CLI_DIR" || { echo "no qos-cli dir"; exit 1; }

# same peer sends the command AND listens for the 1:1 reply
timeout 80 node qos-cli.mjs --room "$ROOM" --name "qlf-cli-poll" \
  --message "/scribe list 500" --listen > "$LOG" 2>&1 &
PID=$!
sleep 70
kill "$PID" 2>/dev/null

# transcript entries look like "HH:MM speaker: text"
grep -oE '[0-9]{1,2}:[0-9]{2} [A-Za-z0-9_-]+: .+' "$LOG" \
  | sed -E 's/ \| .*$//' | awk '!s[$0]++' > "$STATE_DIR/scribe_now.txt"

NEW=$(grep -Fxv -f "$SEEN" "$STATE_DIR/scribe_now.txt")

if [ -z "$NEW" ]; then
  echo "NOCHANGE: no new /scribe list lines ($(wc -l < "$STATE_DIR/scribe_now.txt") total). $(date '+%H:%M')"
  rm -f "$LOG"
  exit 0
fi

cat "$STATE_DIR/scribe_now.txt" >> "$SEEN"
sort -u "$SEEN" -o "$SEEN"

echo "=== NEW /scribe list lines ($(date '+%Y-%m-%d %H:%M')) ==="
echo "$NEW"
echo
FLAG=$(echo "$NEW" | grep -iE 'claude|\bcli\b|task|test|lemma|\bci\b' || true)
if [ -n "$FLAG" ]; then
  echo "*** lines that may be directed at the Claude CLI: ***"
  echo "$FLAG"
fi
rm -f "$LOG"
