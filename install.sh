#!/usr/bin/env bash
#
# Global (user-scope) install for the murica-play Claude Code plugin.
# Registers the marketplace and installs the plugin for your user account, so
# it's active in every project. Requires the `claude` CLI on PATH.
#
set -euo pipefail

MARKETPLACE_REPO="buddhsen-tripathi/murica-play"   # GitHub repo hosting marketplace.json
MARKETPLACE_NAME="murica-play"                      # "name" field in marketplace.json
PLUGIN="murica-play@${MARKETPLACE_NAME}"

echo "→ Registering marketplace ${MARKETPLACE_REPO} ..."
if ! claude plugin marketplace add "$MARKETPLACE_REPO" 2>/dev/null; then
  echo "  (already registered — updating instead)"
  claude plugin marketplace update "$MARKETPLACE_NAME"
fi

echo "→ Installing ${PLUGIN} at user (global) scope ..."
claude plugin install "$PLUGIN" --scope user

echo "✓ Installed globally. Restart Claude Code (or run /reload-plugins) to activate the Stop hook."
