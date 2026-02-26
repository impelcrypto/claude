# Claude Code Configuration

Personal configuration for [Claude Code](https://claude.com/claude-code) CLI.

## Features

### Context Bar (Status Line)

Displays real-time session information in the terminal:

```
Claude Opus 4.5 | ▓▓░░░░░░░░ ~10% of 200k tokens | 💬 Last user message
```

- **Model**: Current model name
- **Context usage**: Visual progress bar with percentage and max tokens
- **Last message**: Your most recent prompt (truncated to 60 chars)

**Configuration**: Edit `scripts/context-bar.sh` to change color theme:
```bash
COLOR="blue"  # Options: gray, orange, blue, teal, green, lavender, rose, gold, slate, cyan
```

### Notifications

macOS notifications with sound effects for session events:

| Event          | Script            | Default Sound |
| -------------- | ----------------- | ------------- |
| Input required | `notify-input.sh` | Ping.aiff     |
| Task completed | `notify-end.sh`   | Hero.aiff     |

### Sound Configuration

Place custom sound files (`.mp3`, `.m4a`, `.wav`) in `assets/` for random selection.

If no custom sounds exist, the system falls back to macOS default sounds.

**Environment variables:**
```bash
export CLAUDE_NOTIFY_SOUND="/path/to/sound.mp3"  # Override sound
export CLAUDE_NOTIFY_VOLUME=0.5                   # 0.0 to 1.0
export CLAUDE_NOTIFY_SOUND=none                   # Disable sound
```

### Skills

Custom slash commands for common workflows:

| Skill         | Command          | Description                                        |
| ------------- | ---------------- | -------------------------------------------------- |
| Weekly Report | `/weekly-report` | Generate report from merged PRs (past 7 days)      |
| Daily Report  | `/daily-report`  | List all commits, PRs, and reviews (past 24 hours) |

## Setup

1. Clone this repo to `~/.claude`
2. Add your own sound files to `assets/` (optional)
3. Restart Claude Code

## File Structure

```
~/.claude/
├── README.md
├── settings.json       # Claude Code settings (hooks, plugins, preferences)
├── scripts/
│   ├── context-bar.sh  # Status line script
│   ├── notify-end.sh   # Task completion notification
│   └── notify-input.sh # Input required notification
├── assets/             # Custom sound files (gitignored)
└── skills/             # Custom skills
    ├── daily-report/
    └── weekly-report/
```

## License

MIT
