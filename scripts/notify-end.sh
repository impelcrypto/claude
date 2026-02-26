#!/bin/bash
# ~/.claude/scripts/notify-end.sh

INPUT=$(cat)
SESSION_DIR=$(basename "$(pwd)")

# Build array from existing sound files only
SOUND_OPTIONS=()
for f in "$HOME/.claude/assets/"*.mp3 "$HOME/.claude/assets/"*.m4a "$HOME/.claude/assets/"*.wav; do
    [ -f "$f" ] && SOUND_OPTIONS+=("$f")
done

# Fallback to system sound if no custom sounds available
if [ ${#SOUND_OPTIONS[@]} -eq 0 ]; then
    NOTIFY_SOUND="/System/Library/Sounds/Hero.aiff"
else
    RANDOM_INDEX=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ' | head -c10)
    RANDOM_INDEX=$((RANDOM_INDEX % ${#SOUND_OPTIONS[@]}))
    NOTIFY_SOUND="${SOUND_OPTIONS[$RANDOM_INDEX]}"
fi
NOTIFY_SOUND="${CLAUDE_NOTIFY_SOUND:-$NOTIFY_SOUND}"
NOTIFY_VOLUME="${CLAUDE_NOTIFY_VOLUME:-0.5}"
# snake.m4a is quieter, so boost its volume
[[ "$NOTIFY_SOUND" == *"snake.m4a" ]] && NOTIFY_VOLUME=1.0

TITLE="ClaudeCode ($SESSION_DIR) Task Done"

# Extract message from transcript if available
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path')
if [ -f "$TRANSCRIPT_PATH" ]; then
    MSG=$(tail -10 "$TRANSCRIPT_PATH" | \
          jq -r 'select(.message.role == "assistant") | .message.content[0].text' 2>/dev/null | \
          tail -1 | tr '\n' ' ' | cut -c1-60)
fi
MSG=${MSG:-"Task completed"}

osascript \
    -e 'on run argv' \
    -e 'display notification (item 1 of argv) with title (item 2 of argv)' \
    -e 'end run' \
    "$MSG" \
    "$TITLE"

if command -v afplay >/dev/null 2>&1 && [ "$NOTIFY_SOUND" != "none" ] && [ "$NOTIFY_VOLUME" != "0" ]; then
    SOUND_FILE="${NOTIFY_SOUND}"
    [[ "$SOUND_FILE" != *.* ]] && SOUND_FILE="${SOUND_FILE}.aiff"

    for DIR in "/System/Library/Sounds" "$HOME/Library/Sounds"; do
        [ -f "$DIR/$SOUND_FILE" ] && { afplay -v "$NOTIFY_VOLUME" "$DIR/$SOUND_FILE" >/dev/null 2>&1 & break; }
    done
    [ -f "$NOTIFY_SOUND" ] && afplay -v "$NOTIFY_VOLUME" "$NOTIFY_SOUND" >/dev/null 2>&1 &
fi
