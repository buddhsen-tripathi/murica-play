# murica-play

A Claude Code plugin that plays the classic **'Murica bald eagle screech** every
time Claude finishes a turn. 🦅🔊

(The bundled clip is the iconic bald eagle meme sound — hence the name.)

Cross-platform: **macOS**, **Linux**, and **Windows** (Git Bash).

---

## Install

In any Claude Code session:

```
/plugin marketplace add buddhsen-tripathi/murica-play
/plugin install murica-play@murica-play
```

This installs **globally** — `--scope` defaults to `user`, so it's active in
every project. Pass `--scope project` or `--scope local` to limit it instead.

Next time Claude stops responding, freedom rings.

## Uninstall

```
/plugin uninstall murica-play@murica-play
```

(Add `/plugin marketplace remove murica-play` to drop the marketplace too.)

## Update

```
/plugin update murica-play@murica-play
```

Or enable auto-update in `/plugin` → **Marketplaces**. Run `/reload-plugins`
(or restart) after updating.

## What it does

Registers a `Stop` hook that plays the bundled clip (`sounds/murica.mp3`) via a
small cross-platform script (`scripts/play.sh`). Playback is **detached**, so it
never delays your session — the eagle screeches while you keep working.

## Requirements

| OS | Player | Notes |
|----|--------|-------|
| macOS | `afplay` | Built in — nothing to install. |
| Linux | `ffplay` / `mpg123` / `mpv` / `cvlc` | Needs one on `PATH` for mp3 (`ffplay` ships with ffmpeg). |
| Windows | Windows Media Player (via PowerShell) | Works in Git Bash/MSYS. |

If no player is found, the hook exits quietly — it never breaks your session.

## Use your own sound

Replace `plugins/murica-play/sounds/murica.mp3` with any `.mp3`/`.wav`/`.m4a` of
the same name, bump `version` in `plugins/murica-play/.claude-plugin/plugin.json`,
then commit and push. Installed users get it on their next update.

## License

MIT — see [LICENSE](LICENSE).
