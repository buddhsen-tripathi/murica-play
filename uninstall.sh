#!/usr/bin/env bash
#
# Global uninstall for the murica-play Claude Code plugin.
# Removes the plugin and the marketplace registration. Requires the `claude`
# CLI on PATH. Tolerant: skips steps that are already undone.
#
set -uo pipefail

MARKETPLACE_NAME="murica-play"
PLUGIN="murica-play@${MARKETPLACE_NAME}"

echo "→ Uninstalling ${PLUGIN} ..."
claude plugin uninstall "$PLUGIN" || echo "  (plugin was not installed)"

echo "→ Removing marketplace ${MARKETPLACE_NAME} ..."
claude plugin marketplace remove "$MARKETPLACE_NAME" || echo "  (marketplace was not registered)"

echo "✓ Removed. Restart Claude Code to fully unload."
