# murica-play

A Claude Code plugin that plays the classic **'Murica bald eagle screech** every
time Claude finishes a turn. 🦅🔊

(The bundled clip is the iconic bald eagle meme sound — hence the name.)

Cross-platform: **macOS**, **Linux**, and **Windows** (Git Bash).

---

## Install (one-time)

In any Claude Code session:

```
/plugin marketplace add buddhsen-tripathi/murica-play
/plugin install murica-play@murica-play
```

Or do it interactively: run `/plugin`, open the **Marketplaces** tab → add
`buddhsen-tripathi/murica-play`, then the **Discover** tab → install
**murica-play**.

That's it — the next time Claude stops responding, freedom rings.

## Global install / uninstall

Prefer one command, or automating it? From a clone of this repo:

```
./install.sh     # register marketplace + install at user (global) scope
./uninstall.sh   # remove the plugin + the marketplace
```

Both wrap the `claude` CLI (`claude plugin install --scope user`, etc.), so the
plugin is enabled for your user across every project.

### Declarative (settings.json)

To install globally by config instead, add to `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "murica-play": { "source": { "source": "github", "repo": "buddhsen-tripathi/murica-play" } }
  },
  "enabledPlugins": { "murica-play@murica-play": true }
}
```

Delete those two entries to uninstall. Restart Claude Code (or `/reload-plugins`)
after any of the above.

## Update (one click)

- **Auto:** in `/plugin` → **Marketplaces** → select `murica-play` → toggle
  **auto-update** on. New versions apply at startup.
- **Manual:**

  ```
  /plugin marketplace update murica-play
  /plugin update murica-play@murica-play
  ```

After an update, run `/reload-plugins` (or restart) so the hook picks up the new files.

## What it does

Registers a `Stop` hook that runs a small cross-platform script
(`scripts/play.sh`) to play the bundled clip (`sounds/murica.mp3`). Playback is
**detached**, so it never delays your session — the eagle screeches while you
keep working.

## Requirements

| OS | Player | Notes |
|----|--------|-------|
| macOS | `afplay` | Built in — nothing to install. |
| Linux | `ffplay` / `mpg123` / `mpv` / `cvlc` | Needs one of these on `PATH` for mp3. (`ffplay` comes with ffmpeg.) |
| Windows | Windows Media Player via PowerShell | Works out of the box in Git Bash/MSYS. |

If no player is found, the hook exits quietly — it never breaks your session.

## Use your own sound

Replace `plugins/murica-play/sounds/murica.mp3` with any `.mp3`/`.wav`/`.m4a`
of the same name, bump `version` in `plugins/murica-play/.claude-plugin/plugin.json`,
commit, and push. Installed users get it on their next update.

## Uninstall

```
/plugin uninstall murica-play@murica-play
```

## License

MIT — see [LICENSE](LICENSE).
