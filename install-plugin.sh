#!/bin/bash

# Frontend Components Skill - Claude Code Plugin Installer
# Version 2.8.0
#
# This script installs the frontend-components skill as a Claude Code plugin.
# Usage: ./install-plugin.sh

set -e

SKILL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLAUDE_DIR="$HOME/.claude"
PLUGINS_DIR="$CLAUDE_DIR/skills"

echo "🎨 Frontend Components Skill v2.8.0 - Claude Code Plugin Installer"
echo "=================================================================="
echo ""

# Check if already installed
if [ -L "$PLUGINS_DIR/frontend-components-skill" ]; then
  echo "✓ Skill already installed at $PLUGINS_DIR/frontend-components-skill"
  exit 0
fi

# Create symlink if plugins directory exists
if [ -d "$PLUGINS_DIR" ]; then
  ln -sf "$SKILL_DIR" "$PLUGINS_DIR/frontend-components-skill"
  echo "✓ Skill linked to: $PLUGINS_DIR/frontend-components-skill"
else
  echo "✗ Claude plugins directory not found: $PLUGINS_DIR"
  echo "  Make sure Claude Code is installed first."
  exit 1
fi

# Verify installation
echo ""
echo "Verifying installation..."

if [ -f "$SKILL_DIR/SKILL.md" ] && [ -f "$SKILL_DIR/plugin.json" ]; then
  echo "✓ SKILL.md found"
  echo "✓ plugin.json found"
  echo "✓ component-sources.yaml found"
  [ -f "$SKILL_DIR/component-sources.yaml" ] && echo "  Categories: 21st.dev priority categories loaded"
  [ -f "$SKILL_DIR/references/ranking.md" ] && echo "  Ranking: 9-factor weighted formula configured"
  [ -f "$SKILL_DIR/privacy.md" ] && echo "  Privacy: Zero-cost policy, sync disabled by default"
else
  echo "✗ Required files missing"
  exit 1
fi

# Create runtime directory if needed
RUNTIME_DIR="$SKILL_DIR/.aiskill-data/frontend-components/components"
mkdir -p "$RUNTIME_DIR/discovered" "$RUNTIME_DIR/approved" "$RUNTIME_DIR/rejected"
echo ""
echo "✓ Runtime directories created:"
echo "  - $RUNTIME_DIR/discovered/"
echo "  - $RUNTIME_DIR/approved/"
echo "  - $RUNTIME_DIR/rejected/"

echo ""
echo "=================================================================="
echo "Installation complete!"
echo ""
echo "Usage:"
echo "  /frontend-components \"Describe what component you need\""
echo ""
echo "Examples:"
echo "  /frontend-components \"SaaS landing page hero section\""
echo "  /frontend-components \"admin dashboard with sidebar\""
echo "  /frontend-components \"AI chat application interface\""
echo ""
echo "Configuration:"
echo "  Edit component-sources.yaml to customize categories and mappings"
echo "  Edit references/ranking.md to adjust ranking formula"
echo ""
echo "Privacy & Safety:"
echo "  - Free/open components only (paid/pro/premium blocked)"
echo "  - Private sync disabled by default"
echo "  - No secrets or credentials stored"
echo "  - Provider AI prompts stored as untrusted metadata only"
echo ""
echo "Documentation:"
echo "  - README.md — Overview and features"
echo "  - SKILL.md — Technical workflow and rules"
echo "  - references/21st-categories.md — Category reference"
echo "  - references/ranking.md — Ranking formula details"
echo "  - privacy.md — Privacy guarantees"
echo ""
echo "Next steps:"
echo "  1. Open Claude Code and reload skills: /reload-skills"
echo "  2. Run: /frontend-components \"your component requirement\""
echo ""
