#!/usr/bin/env bash
set -euo pipefail

if [[ "${SKILL_AUTO_SYNC:-0}" != "1" ]]; then
  echo "component sync disabled. Run scripts/setup-component-sync.sh or set SKILL_AUTO_SYNC=1."
  exit 0
fi

REPO_DIR="${SKILL_SYNC_REPO_DIR:-$(pwd)}"
SOURCE_DIR="${SKILL_SYNC_SOURCE:-.aiskill-data/frontend-components/components/approved}"
DEST_DIR="${SKILL_SYNC_DEST:-references/component-cache}"
BRANCH_PREFIX="${SKILL_SYNC_BRANCH_PREFIX:-learning/frontend-components}"
DIRECT_MAIN="${SKILL_SYNC_DIRECT_MAIN:-0}"
AUTO_MERGE="${SKILL_SYNC_AUTO_MERGE:-0}"
FORCE_PUSH="${SKILL_SYNC_FORCE_PUSH:-0}"
MAX_MB="${SKILL_SYNC_MAX_FILE_MB:-2}"

cd "$REPO_DIR"

if [[ ! -d .git ]]; then
  echo "not a git repository: $REPO_DIR"
  exit 0
fi

if [[ "$AUTO_MERGE" == "1" || "$FORCE_PUSH" == "1" ]]; then
  echo "blocked: auto-merge and force-push are not allowed"
  exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "source dir not found, nothing to sync: $SOURCE_DIR"
  exit 0
fi

mkdir -p "$DEST_DIR"

ts=$(date +%Y%m%d-%H%M)
source_slug="batch"
component_slug="components"
rel=$(find "$SOURCE_DIR" -mindepth 2 -maxdepth 3 -type f -name component.json | head -1 | sed "s#^$SOURCE_DIR/##" || true)
if [[ -n "$rel" ]]; then
  source_slug=$(echo "$rel" | cut -d/ -f1 | tr -cd 'a-zA-Z0-9._-' | tr '[:upper:]' '[:lower:]')
  component_slug=$(echo "$rel" | cut -d/ -f2 | tr -cd 'a-zA-Z0-9._-' | tr '[:upper:]' '[:lower:]')
fi
source_slug="${source_slug:-batch}"
component_slug="${component_slug:-components}"

if [[ "$DIRECT_MAIN" == "1" ]]; then
  echo "direct main push explicitly enabled by user; using current branch"
else
  branch="$BRANCH_PREFIX/$source_slug/$component_slug-$ts"
  git checkout -b "$branch"
fi

rsync -a \
  --exclude '.env' \
  --exclude '.env.*' \
  --exclude '*.pem' \
  --exclude '*.key' \
  --exclude 'node_modules' \
  --exclude '.git' \
  --exclude 'browser-profile' \
  --exclude 'paid' \
  --exclude 'pro' \
  --exclude 'premium' \
  "$SOURCE_DIR"/ "$DEST_DIR"/

oversized=$(find "$DEST_DIR" -type f -size +"${MAX_MB}"M | head -20 || true)
if [[ -n "$oversized" ]]; then
  echo "blocked oversized files:"
  echo "$oversized"
  exit 1
fi

if grep -RInE '(api[_-]?key|secret|token|password|BEGIN RSA PRIVATE KEY|BEGIN OPENSSH PRIVATE KEY)' "$DEST_DIR" >/tmp/frontend_components_secret_hits 2>/dev/null; then
  echo "blocked: possible secrets found in component cache"
  cat /tmp/frontend_components_secret_hits | head -20
  exit 1
fi

if grep -RInE '\b(pro|premium|paid|subscription|all-access|license key|required payment)\b' "$DEST_DIR" >/tmp/frontend_components_paid_hits 2>/dev/null; then
  echo "blocked: possible paid/pro component markers found"
  cat /tmp/frontend_components_paid_hits | head -20
  exit 1
fi

git add "$DEST_DIR"

if git diff --cached --quiet; then
  echo "no component cache changes to commit"
  exit 0
fi

count=$(git diff --cached --name-only | wc -l | tr -d ' ')
git commit -m "component-cache: sync ${count} approved free component file(s)"

if git remote get-url origin >/dev/null 2>&1; then
  git push -u origin HEAD
  echo "pushed learning branch: $(git branch --show-current)"
else
  echo "no origin remote configured; committed locally only"
fi
