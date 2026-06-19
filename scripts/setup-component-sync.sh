#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${SKILL_CONFIG_DIR:-.aiskill-data/frontend-components}"
CONFIG_FILE="$CONFIG_DIR/component-sync.env"
mkdir -p "$CONFIG_DIR"

cat <<'MSG'
Optional component branch sync.

This public-repo-safe feature stores approved free/open discovered components into
references/component-cache/ and pushes them to separate Git branches for review.

Default is disabled.
MSG

read -r -p "Enable component branch sync? [y/N]: " ans
case "${ans:-N}" in
  y|Y|yes|YES)
    ;;
  *)
    cat > "$CONFIG_FILE" <<CFG
SKILL_AUTO_SYNC=0
CFG
    echo "Component sync disabled. Config written: $CONFIG_FILE"
    exit 0
    ;;
esac

read -r -p "Skill repo directory [$(pwd)]: " repo_dir
repo_dir="${repo_dir:-$(pwd)}"
read -r -p "Branch prefix [learning/frontend-components]: " branch_prefix
branch_prefix="${branch_prefix:-learning/frontend-components}"
read -r -p "Approved components source [.aiskill-data/frontend-components/components/approved]: " source_dir
source_dir="${source_dir:-.aiskill-data/frontend-components/components/approved}"
read -r -p "Destination folder [references/component-cache]: " dest_dir
dest_dir="${dest_dir:-references/component-cache}"

cat > "$CONFIG_FILE" <<CFG
SKILL_AUTO_SYNC=1
SKILL_SYNC_REPO_DIR=$repo_dir
SKILL_SYNC_BRANCH_PREFIX=$branch_prefix
SKILL_SYNC_SOURCE=$source_dir
SKILL_SYNC_DEST=$dest_dir
SKILL_SYNC_BRANCH_MODE=per_component
SKILL_SYNC_DIRECT_MAIN=0
SKILL_SYNC_AUTO_MERGE=0
SKILL_SYNC_FORCE_PUSH=0
CFG

cat <<MSG
Component sync enabled.
Config written: $CONFIG_FILE

Load it before syncing:
  set -a; source $CONFIG_FILE; set +a
  scripts/sync-components-to-branch.sh

Notes:
- Pushes to separate learning branches.
- Does not auto-merge.
- Does not push paid/pro/private/restricted components.
- Do not commit .aiskill-data/ to the public repository.
MSG
