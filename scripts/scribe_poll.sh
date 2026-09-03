#!/usr/bin/env bash
# scribe_poll.sh — connect to the quantum-os room, pull `/scribe list 500`,
# print only transcript lines not seen on a previous run, flag lines aimed at
# the Claude CLI, and GREET any genuinely new human joiner once. Session-cron helper.
#
# Usage: scripts/scribe_poll.sh
# State (scratchpad):
#   scribe_seen.txt     — transcript lines already reported
#   scribe_greeted.txt  — joiner names already greeted

set -u
ROOM="cap:room:05214747236101414325074505234721"
CLI_DIR="$HOME/quantum-os/scripts/qos-cli"
STATE_DIR="/tmp/claude-1000/-home-jimscarver-quantum-logical-framework/7cbbf27c-8b68-4ebc-8703-e77936ef20f2/scratchpad"
SEEN="$STATE_DIR/scribe_seen.txt"
GREETED="$STATE_DIR/scribe_greeted.txt"
LOG="$STATE_DIR/scribe_poll_$(date +%s).log"
# names that are never greeted: this poller, other CLI peers, the room bots
SELF_RE='^(qlf-cli-poll|qlf-claude|qlf-claude-listen|qlf-scribe-check|qlf-cli-.*|facilitator|skeptic|scribe)$'
mkdir -p "$STATE_DIR"; touch "$SEEN" "$GREETED"

cd "$CLI_DIR" || { echo "no qos-cli dir"; exit 1; }

# same peer sends the command AND listens for the 1:1 reply
timeout 80 node qos-cli.mjs --room "$ROOM" --name "qlf-cli-poll" \
  --message "/scribe list 500" --listen > "$LOG" 2>&1 &
PID=$!
sleep 70
kill "$PID" 2>/dev/null

# transcript entries look like "HH:MM speaker: text"; drop our own poller's lines
# and the facilitator's welcome for our own poller (pure self-noise)
grep -oE '[0-9]{1,2}:[0-9]{2} [A-Za-z0-9_-]+: .+' "$LOG" \
  | sed -E 's/ \| .*$//' \
  | grep -vE '[0-9]{1,2}:[0-9]{2} qlf-cli-poll: ' \
  | grep -vE '[0-9]{1,2}:[0-9]{2} facilitator: .*Welcome, qlf-cli-poll!' \
  | awk '!s[$0]++' > "$STATE_DIR/scribe_now.txt"

NEW=$(grep -Fxv -f "$SEEN" "$STATE_DIR/scribe_now.txt")

if [ -z "$NEW" ]; then
  echo "NOCHANGE: no new /scribe list lines ($(wc -l < "$STATE_DIR/scribe_now.txt") total). $(date '+%H:%M')"
  rm -f "$LOG"
  exit 0
fi

cat "$STATE_DIR/scribe_now.txt" >> "$SEEN"
sort -u "$SEEN" -o "$SEEN"

# --- greet genuinely new joiners (once each) ---
# facilitator emits "👋 Welcome, <name>!" for every join
NEWJOINERS=$(echo "$NEW" | grep -oE 'Welcome, [^!]+!' | sed -E 's/^Welcome, //; s/!$//' | sort -u)
GREET_DONE=""
while IFS= read -r name; do
  [ -z "$name" ] && continue
  echo "$name" | grep -qE "$SELF_RE" && continue
  grep -Fxq "$name" "$GREETED" && continue
  MSG="👋 Hi $name — I'm the QLF Claude CLI. I watch the room and work the quantum-logical-framework repo (proofs, docs, the census tools). Ask me anything, or say what you're exploring. About this room: https://github.com/rchain-community/quantum-os/blob/main/MyRoom.md"
  timeout 45 node qos-cli.mjs --room "$ROOM" --name "qlf-cli-poll" --message "$MSG" --wait 12000 --linger 4000 >/dev/null 2>&1
  echo "$name" >> "$GREETED"
  GREET_DONE="$GREET_DONE $name"
done <<< "$NEWJOINERS"

echo "=== NEW /scribe list lines ($(date '+%Y-%m-%d %H:%M')) ==="
echo "$NEW"
echo
[ -n "$GREET_DONE" ] && echo "GREETED new joiner(s):$GREET_DONE" && echo
FLAG=$(echo "$NEW" | grep -iE 'claude|\bcli\b|task|test|lemma|\bci\b' || true)
if [ -n "$FLAG" ]; then
  echo "*** lines that may be directed at the Claude CLI: ***"
  echo "$FLAG"
fi
rm -f "$LOG"
