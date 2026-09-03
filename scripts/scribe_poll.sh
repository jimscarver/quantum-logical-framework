#!/usr/bin/env bash
# scribe_poll.sh — two-phase room watcher for the quantum-os collab room.
#
#   Phase 1 (every run, cheap ~20s): a LISTEN-ONLY probe. No /scribe list sent.
#     Catches broadcast chat + "Welcome, <name>!" joins. If nothing new -> NOCHANGE, exit.
#   Phase 2 (only when Phase 1 saw activity): pull /scribe list 500, diff, greet new
#     joiners once, report new transcript lines and any aimed at the CLI.
#
# Usage: scripts/scribe_poll.sh
# State (scratchpad):
#   scribe_probe_seen.txt — broadcast chat/join lines the cheap probe has seen
#   scribe_seen.txt       — full transcript lines already reported
#   scribe_greeted.txt    — joiner names already greeted

set -u
ROOM="cap:room:05214747236101414325074505234721"
CLI_DIR="$HOME/quantum-os/scripts/qos-cli"
STATE_DIR="/tmp/claude-1000/-home-jimscarver-quantum-logical-framework/7cbbf27c-8b68-4ebc-8703-e77936ef20f2/scratchpad"
PROBE_SEEN="$STATE_DIR/scribe_probe_seen.txt"
SEEN="$STATE_DIR/scribe_seen.txt"
GREETED="$STATE_DIR/scribe_greeted.txt"
LOG="$STATE_DIR/scribe_poll_$(date +%s).log"
SELF_RE='^(qlf-cli-poll|qlf-claude|qlf-claude-listen|qlf-scribe-check|qlf-cli-.*|facilitator|skeptic|scribe)$'
mkdir -p "$STATE_DIR"; touch "$PROBE_SEEN" "$SEEN" "$GREETED"
cd "$CLI_DIR" || { echo "no qos-cli dir"; exit 1; }

# strip qos-cli noise -> keep genuine broadcast chat / join lines
filter_activity() {
  grep -E '^\[[a-z0-9]+…\] ' "$1" \
    | sed -E 's/^\[[a-z0-9]+…\] //' \
    | grep -vE '^\{"kind"' \
    | grep -vE '^(Hi — I.m (skeptic|facilitator|scribe)|👋 Yes, I.m here — scribe)' \
    | grep -vE 'Welcome, (qlf-cli-poll|qlf-claude|qlf-claude-listen|qlf-scribe-check|qlf-cli-)' \
    | grep -vE '^📜 last ' \
    | sed -E 's/[[:space:]]+$//' | awk 'NF'
}

# ---------- Phase 1: cheap listen-only probe ----------
# listen ~45s of the 60s tick so live chat sent between ticks is rarely missed;
# any activity then triggers a full /scribe list catch-up anyway.
timeout 52 node qos-cli.mjs --room "$ROOM" --name "qlf-cli-poll" --listen > "$LOG" 2>&1 &
PID=$!; sleep 45; kill "$PID" 2>/dev/null

filter_activity "$LOG" | awk '!s[$0]++' > "$STATE_DIR/probe_now.txt"
PROBE_NEW=$(grep -Fxv -f "$PROBE_SEEN" "$STATE_DIR/probe_now.txt" || true)
cat "$STATE_DIR/probe_now.txt" >> "$PROBE_SEEN"
sort -u "$PROBE_SEEN" -o "$PROBE_SEEN"
# keep the probe-seen file bounded
tail -n 400 "$PROBE_SEEN" > "$PROBE_SEEN.tmp" && mv "$PROBE_SEEN.tmp" "$PROBE_SEEN"

if [ -z "$PROBE_NEW" ]; then
  echo "NOCHANGE: quiet room, no /scribe list pulled. $(date '+%H:%M')"
  rm -f "$LOG"; exit 0
fi

echo "ACTIVITY detected by probe:"; echo "$PROBE_NEW"; echo
rm -f "$LOG"

# ---------- Phase 2: full /scribe list pull ----------
LOG="$STATE_DIR/scribe_poll_$(date +%s).log"
timeout 80 node qos-cli.mjs --room "$ROOM" --name "qlf-cli-poll" \
  --message "/scribe list 500" --listen > "$LOG" 2>&1 &
PID=$!; sleep 70; kill "$PID" 2>/dev/null

grep -oE '[0-9]{1,2}:[0-9]{2} [A-Za-z0-9_-]+: .+' "$LOG" \
  | sed -E 's/ \| .*$//' \
  | grep -vE '[0-9]{1,2}:[0-9]{2} qlf-cli-poll: ' \
  | grep -vE '[0-9]{1,2}:[0-9]{2} facilitator: .*Welcome, qlf-cli-poll!' \
  | awk '!s[$0]++' > "$STATE_DIR/scribe_now.txt"

NEW=$(grep -Fxv -f "$SEEN" "$STATE_DIR/scribe_now.txt" || true)
if [ -z "$NEW" ]; then
  echo "(probe saw activity but /scribe list added no new timestamped lines)"
  rm -f "$LOG"; exit 0
fi
cat "$STATE_DIR/scribe_now.txt" >> "$SEEN"
sort -u "$SEEN" -o "$SEEN"

# greet genuinely new joiners once
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
echo "$NEW"; echo
[ -n "$GREET_DONE" ] && echo "GREETED new joiner(s):$GREET_DONE" && echo
FLAG=$(echo "$NEW" | grep -iE 'claude|\bcli\b|task|test|lemma|\bci\b' || true)
if [ -n "$FLAG" ]; then
  echo "*** lines that may be directed at the Claude CLI: ***"
  echo "$FLAG"
fi
rm -f "$LOG"
