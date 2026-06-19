# Frontend Components Skill

A Claude Code-style skill for finding, indexing, installing, adapting, and previewing real UI components from free/open component registries.

## Main Idea

Avoid generic AI-generated frontend by using real UI component sources:

- registry.directory
- shadcn registry directory
- 21st.dev
- Magic UI
- Blocks.so
- Aceternity UI
- Kokonut UI
- Untitled UI React
- Tailgrids
- HyperUI
- Mamba UI
- Meraki UI
- Flowbite
- Preline
- FlyonUI
- Uiverse

## Safety

This skill is not a website cloning tool. It imports only from allowed registries/copy-paste/open-source sources and treats unclear sources as inspiration-only.

## Learning System

The skill stores mutable learning files under `knowledge/`:

- selectors
- page patterns
- install command patterns
- failure logs
- component catalog
- installed component log

Stable learnings can be reviewed and merged into future skill versions.

## Provider AI Prompt Extraction

Version 2.1 adds support for extracting provider-supplied AI prompts such as "Copy prompt", "Copy for Claude", "Copy for Cursor", and "Copy for v0". These prompts are stored as untrusted metadata and used only as component-specific guidance after safety scanning.

## v2.2 Trusted Marketplace + Design Tokens

Version 2.2 adds trusted marketplace mode for known free/open component marketplaces. It reduces per-component license friction while still recording source provenance and blocking paid/pro/restricted components.

It also adds design-token/theme extraction for colors, fonts, spacing, radius, shadows, motion, and visual harmonization across imported components.

## v2.3 Free-Tier-Only Ranking

Version 2.3 enforces a strict zero-cost component policy. The skill must never ask the user to pay, bypass, crack, leak, or scrape paid/pro components. It filters paid/pro results before ranking and selects the best free component based on requirement fit, installability, visual quality, adaptability, provider prompt quality, and previous success feedback.

## v2.4 Compact Skill

Version 2.4 makes `SKILL.md` token-efficient. The verbose v2.3 spec is moved to `references/full-spec-v2.3.md`; Claude should load it only when implementing/debugging a specific feature. The frontmatter now keeps version under `metadata` for stricter Agent Skills compatibility.

## v2.5 Component Storage Architecture

Version 2.5 adds a dedicated `components/` architecture. Runtime discoveries are stored under `.aiskill-data/frontend-components/components/discovered/`; validated reusable components can be promoted into `components/predefined/` for publishing.

## v2.6 Private Auto-Sync

Version 2.6 adds an owner-only auto-sync feature. When enabled with `SKILL_AUTO_SYNC=1`, validated free/open components from the runtime approved folder can be mirrored into `references/component-cache/` and pushed to the configured GitHub repo.

This is disabled by default and must not be used to push paid/pro/private/restricted code.

## v2.7 Private Branch Learning

Version 2.7 keeps private auto-sync disabled by default. On setup, `scripts/setup-private-sync.sh` asks the owner whether to enable continuous component learning. When enabled, new approved free/open components are pushed to separate `learning/frontend-components/...` branches for manual review and merge.

## v2.8 21st.dev Priority Categories & Requirement Matching

Version 2.8 adds intelligent requirement-to-component matching:

- **12 priority categories** from 21st.dev (hero, landing, features, CTA, testimonials, pricing, AI chat, framer motion, product card, modal, buttons, about)
- **10 page-type templates** (homepage, landing, dashboard, ecommerce, B2B, AI apps, docs, monitoring, etc.)
- **Requirement classification** (page type, business type, component intent)
- **Strict blocking rules** (paid/pro/premium/login-required components blocked before ranking)
- **Smart ranking formula** (requirement fit 30%, category match 20%, free-tier 15%, installability 10%, visual quality 10%, others 15%)
- **Download limits** (max 5 candidates, max 1 installed per request, max 3 categories searched)
- **Component selection priority** (1 layout + 1 conversion + 1 trust + 1 state component per page)

When you ask for a component, the skill now:

1. Classifies your page type and business domain
2. Loads matching 21st.dev categories (required + optional)
3. Searches **only** those categories (never random)
4. Blocks paid/pro components before ranking
5. Ranks candidates by requirement fit + installability + quality
6. Returns top 3-5 options
7. Installs the best candidate (unless you ask for more)

This prevents downloading random flashy components and ensures you get components that actually match your use case.

See `component-sources.yaml` for the full category map and `references/ranking.md` for scoring details.

## Privacy and Security

Read [`privacy.md`](./privacy.md) before enabling private sync or publishing this skill.

Default behavior is safe and local-first:

- Private auto-sync is disabled.
- No GitHub push happens unless the owner explicitly enables it.
- Runtime learning stays under `.aiskill-data/frontend-components/`.
- Paid/pro/private components are blocked.
- Provider AI prompts are treated as untrusted external guidance.
- Secrets, `.env` files, tokens, private keys, browser profiles, and `node_modules` must never be stored or pushed.

To enable private branch-based learning sync, run:

```bash
scripts/setup-private-sync.sh
```

The setup script asks for confirmation. If enabled, approved free/open components are pushed only to separate review branches:

```txt
learning/frontend-components/<source>/<component-slug>-<yyyymmdd-hhmm>
```

No auto-merge is performed. The owner manually reviews and merges good components.

Before publishing the skill, remove or review:

```txt
.aiskill-data/
references/component-cache/
private/*.env
```

Do not publish secrets, paid/pro code, private remotes, or local machine paths.

## Public Repo Update

This repository is public-safe. Component branch sync is optional and disabled by default.

Use:

```bash
scripts/setup-component-sync.sh
```

If enabled, approved free/open components are pushed only to review branches:

```txt
learning/frontend-components/<source>/<component-slug>-<yyyymmdd-hhmm>
```

Do not commit `.aiskill-data/`, `.env`, tokens, keys, browser profiles, paid/pro code, or private component data.
