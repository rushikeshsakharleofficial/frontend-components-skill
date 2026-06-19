# Changelog

## 2.0.0

- Added multi-source component scraping strategy.
- Added registry.directory, Magic UI, Blocks.so, Aceternity UI, Kokonut UI, Untitled UI, Tailgrids, HyperUI, Mamba UI, Meraki UI, Flowbite, Preline, FlyonUI, Uiverse.
- Added continuous learning system using local knowledge files.
- Added selector confidence model.
- Added self-healing scraper strategy.
- Added MCP tool design.
- Added publish checklist.
- Added safety/license rules.

## 2.1.0

- Added provider AI prompt extraction.
- Added safe prompt wrapper and prompt-injection guardrails.
- Added Playwright clipboard extraction pattern for prompt buttons.
- Added prompt metadata schema.
- Added prompt extraction source config fields.
- Added learning rules for prompt selectors.

## 2.2.0

- Added Trusted Component Marketplace Mode.
- Reduced per-component license friction for known free/open component marketplaces.
- Added source-level usage profile and provenance recording.
- Added design empty/theme starter extraction.
- Added design token schema and design DNA extraction.
- Added design-sources.yaml.
- Added theme harmonization prompt.

## 2.3.0

- Added strict free-tier-only budget policy.
- Blocked paid/pro/premium/subscription/trial/payment/bypass workflows.
- Added free-tier-first candidate filter.
- Added requirement-based best component finder.
- Added component scoring formula.
- Added continuous ranking learning files.
- Added templates for requirement ranking and free-tier policy.

## 2.4.0

- Converted SKILL.md to compact token-efficient format.
- Moved verbose v2.3 instructions to references/full-spec-v2.3.md.
- Moved version into metadata frontmatter for stricter Agent Skills compatibility.
- Added explicit token budget rules.
- Kept free-tier-only, ranking, prompt extraction, theme extraction, and learning behavior.

## 2.5.0

- Added `components/` architecture.
- Added predefined component folder.
- Added runtime discovered/approved/rejected component flow.
- Added component record template and schema.
- Added component-storage reference doc.
- Added token rule: load metadata first, code only when needed.

## 2.6.0-private

- Added owner-only private GitHub auto-sync feature.
- Added `references/component-cache/` as a safe reference cache.
- Added `references/private-auto-sync.md`.
- Added `private/auto-sync.template.yaml`.
- Added `scripts/private-sync-components.sh`.
- Added safety checks for secrets, oversized files, and paid/pro path names.

## 2.6.1-private

- Renamed skill to `frontend-components`.
- Updated runtime data path to `.aiskill-data/frontend-components/`.
- Created renamed publish bundle.

## 2.7.0-private

- Private auto-sync remains disabled by default.
- Added install/setup prompt via `scripts/setup-private-sync.sh`.
- Added branch-based continuous learning.
- New discoveries push to separate `learning/frontend-components/...` branches.
- No direct main push, no auto-merge, no force-push by default.

## 2.8.0-private

- Added `privacy.md`.
- Updated README with privacy/security guidance.
- Added privacy requirement to SKILL.md.
- Documented local-first behavior, opt-in sync, branch-only pushes, and data deletion.

## 2.9.0

- Converted private-only feature into public-repo-safe optional branch sync.
- Removed `private/` folder.
- Renamed scripts to `setup-component-sync.sh` and `sync-components-to-branch.sh`.
- Added `config/auto-sync.template.yaml`.
- Added public-safe `.gitignore`.
- Rewrote privacy policy for public repository usage.
- Kept sync disabled by default and branch-only.
