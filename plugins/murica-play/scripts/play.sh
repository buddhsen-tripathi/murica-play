#!/usr/bin/env bash
# Cross-platform sound player for the murica-play Claude Code plugin.
# Usage: play.sh /path/to/sound.mp3
#
# Plugin hooks run synchronously (no "async" field), so we DETACH playback and
# return immediately — the Stop hook must never make you wait for audio.
# Best-effort by design: if no player is found it exits 0 silently.
set -u

SOUND="${1:-}"
[ -z "$SOUND" ] && exit 0
[ -f "$SOUND" ] || exit 0

# Run a command fully detached (survives this script exiting) and return now.
detach() { ( "$@" >/dev/null 2>&1 & ); }

case "$(uname -s)" in
  Darwin)
    # afplay ships with macOS — nothing to install.
    command -v afplay >/dev/null 2>&1 && detach afplay "$SOUND"
    ;;
  Linux)
    # Prefer mp3-capable players. (paplay/aplay decode WAV only, so they're skipped.)
    for player in ffplay mpg123 mpv cvlc; do
      command -v "$player" >/dev/null 2>&1 || continue
      case "$player" in
        ffplay) detach ffplay -nodisp -autoexit -loglevel quiet "$SOUND" ;;
        mpg123) detach mpg123 -q "$SOUND" ;;
        mpv)    detach mpv --no-video --really-quiet "$SOUND" ;;
        cvlc)   detach cvlc --play-and-exit --quiet "$SOUND" ;;
      esac
      break
    done
    ;;
  MINGW*|MSYS*|CYGWIN*|Windows_NT)
    # Windows via Git Bash/MSYS: SoundPlayer is WAV-only, so drive Windows Media
    # Player through PowerShell, which handles mp3.
    if command -v powershell >/dev/null 2>&1; then
      win_path=$(cygpath -w "$SOUND" 2>/dev/null || printf '%s' "$SOUND")
      detach powershell -NoProfile -Command \
        "\$p = New-Object -ComObject WMPlayer.OCX; \$p.URL = '$win_path'; \$p.controls.play(); Start-Sleep -Milliseconds 400; while (\$p.playState -eq 3) { Start-Sleep -Milliseconds 200 }"
    fi
    ;;
esac

exit 0
