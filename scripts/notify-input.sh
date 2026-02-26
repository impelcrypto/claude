#!/bin/bash
# ~/.claude/scripts/notify-input.sh

SESSION_DIR=$(basename "$(pwd)")

# Build array from existing sound files only
SOUND_OPTIONS=()
for f in "$HOME/.claude/assets/"*.mp3 "$HOME/.claude/assets/"*.m4a "$HOME/.claude/assets/"*.wav; do
    [ -f "$f" ] && SOUND_OPTIONS+=("$f")
done

# Fallback to system sound if no custom sounds available
if [ ${#SOUND_OPTIONS[@]} -eq 0 ]; then
    NOTIFY_SOUND="/System/Library/Sounds/Ping.aiff"
else
    RANDOM_INDEX=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ' | head -c10)
    RANDOM_INDEX=$((RANDOM_INDEX % ${#SOUND_OPTIONS[@]}))
    NOTIFY_SOUND="${SOUND_OPTIONS[$RANDOM_INDEX]}"
fi
NOTIFY_SOUND="${CLAUDE_NOTIFY_SOUND:-$NOTIFY_SOUND}"
NOTIFY_VOLUME="${CLAUDE_NOTIFY_VOLUME:-0.5}"

TITLE="ClaudeCode ($SESSION_DIR) Input Required"
MSG="Waiting for your input"

osascript \
    -e 'on run argv' \
    -e 'display notification (item 1 of argv) with title (item 2 of argv)' \
    -e 'end run' \
    "$MSG" \
    "$TITLE"

if command -v afplay >/dev/null 2>&1 && [ "$NOTIFY_SOUND" != "none" ] && [ "$NOTIFY_VOLUME" != "0" ]; then
    SOUND_PATH=""
    if [ -f "$NOTIFY_SOUND" ]; then
        SOUND_PATH="$NOTIFY_SOUND"
    else
        SOUND_FILE="$NOTIFY_SOUND"
        case "$SOUND_FILE" in
            *.*) : ;;
            *) SOUND_FILE="${SOUND_FILE}.aiff" ;;
        esac
        if [ -f "/System/Library/Sounds/$SOUND_FILE" ]; then
            SOUND_PATH="/System/Library/Sounds/$SOUND_FILE"
        elif [ -f "$HOME/Library/Sounds/$SOUND_FILE" ]; then
            SOUND_PATH="$HOME/Library/Sounds/$SOUND_FILE"
        fi
    fi

    if [ -n "$SOUND_PATH" ]; then
        if [[ "$NOTIFY_VOLUME" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
            afplay -v "$NOTIFY_VOLUME" "$SOUND_PATH" >/dev/null 2>&1 &
        else
            afplay "$SOUND_PATH" >/dev/null 2>&1 &
        fi
    fi
fi
