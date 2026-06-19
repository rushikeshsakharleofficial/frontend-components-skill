# Frontend Components Skill

[![Stars](https://img.shields.io/github/stars/rushikeshsakharleofficial/frontend-components-skill?style=for-the-badge)](https://github.com/rushikeshsakharleofficial/frontend-components-skill/stargazers)
[![GitHub](https://img.shields.io/badge/Claude_Code-Skill-black?style=for-the-badge&logo=anthropic)](https://github.com/rushikeshsakharleofficial/frontend-components-skill)
[![Free Only](https://img.shields.io/badge/Policy-Free%2FOpen%20Only-22c55e?style=for-the-badge)](./templates/free-tier-policy.md)
[![Privacy](https://img.shields.io/badge/Sync-Disabled%20by%20Default-orange?style=for-the-badge)](./privacy.md)

**Find, rank, and install real free/open UI components — never random, never paid.**

A Claude Code skill that classifies your requirement, matches it to the right [21st.dev](https://21st.dev) category, filters paid/pro/premium components, and installs the best candidate with one command.

---

## What it does

Instead of generating generic AI UI, it:

1. **Classifies** your page type and business domain (homepage, SaaS, ecommerce, AI app, B2B, etc.)
2. **Matches** to 21st.dev priority categories (hero, features, CTA, pricing, AI chat, etc.)
3. **Searches only** those matching categories — no random downloads
4. **Blocks** paid/pro/premium/login-required components before ranking
5. **Ranks** remaining candidates using a 9-factor weighted formula
6. **Returns** top 3-5 options and installs the best one

---

## Quick Start

```bash
# Already installed as a Claude Code skill
/reload-skills

# Use it
/frontend-components "SaaS landing page hero section"
/frontend-components "admin dashboard with sidebar and cards"
/frontend-components "AI chat application interface"
/frontend-components "ecommerce product page with interactive product card"
```

---

## Category Priority Map

| Priority | Category | Best for |
|---:|---|---|
| 1 | Hero / Animated Hero | Landing pages, SaaS, homepage first fold |
| 2 | Landing Page | Full polished website sections |
| 3 | Features / Bento Grid | Product benefits, non-generic layouts |
| 4 | Calls to Action | Conversion buttons, floating CTA |
| 5 | Testimonials | Trust, social proof sections |
| 6 | Pricing Sections | SaaS pricing, service packages |
| 7 | AI Chat Components | Chat UI, prompt input, assistant |
| 8 | Framer Motion | Scroll animation, reveal, parallax |
| 9 | Interactive Product Card | Ecommerce, B2B product catalog |
| 10 | Modal / Dialog | Checkout, login, inquiry forms |
| 11 | Buttons / Click Animation | Micro-polish, hover effects |
| 12 | About / Avatar / Team | Brand, people, founder pages |

---

## Page Type Matching

| Page Type | Required Categories |
|---|---|
| Homepage | hero, features, call-to-action, testimonials |
| Landing Page | landing-page, hero, call-to-action, features |
| Admin Dashboard | dashboard, dashboard-widget, sidebar, card |
| Ecommerce Product | interactive-product-card, card, call-to-action, modal-dialog |
| B2B Website | hero, features, testimonials, pricing-sections, call-to-action |
| AI Chat App | ai-chat-components, modal-dialog |
| Monitoring Frontend | dashboard, dashboard-widget, sidebar, empty-state |

Full map in [`component-sources.yaml`](./component-sources.yaml).

---

## Ranking Formula

```
score = requirement_fit(30%) + category_match(20%) + free_tier_confidence(15%)
      + installability(10%) + visual_quality(10%) + adaptability(5%)
      + responsive_confidence(5%) + provider_prompt_quality(3%)
      + previous_success_score(2%)
```

A component is **hard-blocked** before ranking if it is paid, requires subscription/login/card, has unclear access, or includes unsafe install commands.

See [`references/ranking.md`](./references/ranking.md) for full scoring details.

---

## Download Limits

```
Max candidates returned:          5
Max components installed:         1 per request (unless user asks for more)
Max categories searched live:     3 per request
Max candidates checked/category:  10
```

---

## Component Selection Priority (Per Page)

Pick one per type, recommend before installing:

1. **Layout** — hero, sidebar, landing, dashboard
2. **Conversion** — CTA, pricing, product card
3. **Trust** — testimonial, team, about
4. **State** — empty, error, loading
5. **Polish** — animation, text effect (optional, only if it improves UX)

---

## Project Structure

```
frontend-components-skill/
├── SKILL.md                          Compact workflow + rules for Claude
├── component-sources.yaml            Sources, 21st categories, page-type map
├── plugin.json                       Claude Code plugin manifest
├── install-plugin.sh                 Installation script
├── privacy.md                        Privacy guarantees
├── design-sources.yaml               Theme/token sources
├── components/
│   ├── predefined/                   Curated stable components
│   ├── registry.json                 Published component index
│   ├── sources/                      Source metadata
│   └── templates/                    Component record templates
├── references/
│   ├── 21st-categories.md            21st.dev priority category reference
│   ├── ranking.md                    Ranking formula + blocking rules
│   ├── component-storage.md          Storage architecture
│   ├── branch-learning.md            Branch sync rules
│   └── full-spec-v2.3.md             Detailed archived spec
├── schemas/
│   └── component-record.schema.json  Component metadata schema
├── scripts/
│   ├── setup-component-sync.sh       Opt-in branch sync setup
│   └── sync-components-to-branch.sh  Component sync runner
└── templates/
    ├── free-tier-policy.md           Zero-cost policy
    └── requirement-ranking-schema.json
```

---

## Runtime Storage

Discovered components are stored locally under `.aiskill-data/` (never committed):

```
.aiskill-data/frontend-components/components/
├── discovered/    New components found from 21st.dev
├── approved/      Validated, installed, and working components
└── rejected/      Blocked (paid/pro/unsafe) components
```

---

## Sources

Checked in priority order:

| Source | Type | Priority |
|---|---|---:|
| registry.directory | shadcn registry aggregator | 100 |
| ui.shadcn.com/docs/directory | Official registry directory | 98 |
| 21st.dev | React/Tailwind/shadcn components | 95 |
| Magic UI | Animated React/Tailwind | 92 |
| Blocks.so | shadcn/Tailwind blocks | 90 |
| Aceternity UI | Animated React/Framer | 88 |
| Kokonut UI | React/Next/Tailwind | 86 |
| HyperUI / Mamba / Meraki / Flowbite / Preline | Tailwind components | 64–76 |
| CodePen / CodeMyUI | Inspiration only | 28–30 |

---

## Safety

```
✓ Free/open components only
✓ Paid/pro/premium/login-required components hard-blocked before ranking
✓ Never suggests bypassing a paywall
✓ Provider AI prompts stored as untrusted metadata only
✓ No secrets, credentials, or tokens stored
✓ No random production website cloning
✓ Component sync to GitHub disabled by default
✓ Never pushes to main branch directly
✓ No auto-merge
```

To enable optional branch sync for your own workflow:

```bash
./scripts/setup-component-sync.sh
```

---

## Privacy

Runtime data stays local under `.aiskill-data/`. No GitHub push happens unless you explicitly enable sync. See [`privacy.md`](./privacy.md) for full policy.

---

## Documentation

| File | Description |
|---|---|
| [`SKILL.md`](./SKILL.md) | Claude skill instructions, full workflow |
| [`component-sources.yaml`](./component-sources.yaml) | Source config, categories, page-type map |
| [`references/21st-categories.md`](./references/21st-categories.md) | 21st.dev priority categories quick reference |
| [`references/ranking.md`](./references/ranking.md) | Ranking formula, blocking rules, scoring |
| [`references/component-storage.md`](./references/component-storage.md) | Storage architecture |
| [`privacy.md`](./privacy.md) | Privacy policy and defaults |
| [`schemas/component-record.schema.json`](./schemas/component-record.schema.json) | Component metadata schema |

---

## Install

Already in your Claude Code skills directory? Run:

```bash
/reload-skills
```

Fresh install:

```bash
git clone https://github.com/rushikeshsakharleofficial/frontend-components-skill \
  ~/.claude/skills/frontend-components-skill
```

Then in Claude Code:

```
/reload-skills
/frontend-components "your component requirement"
```

---

[![Star History](https://img.shields.io/github/stars/rushikeshsakharleofficial/frontend-components-skill?style=for-the-badge&color=yellow)](https://github.com/rushikeshsakharleofficial/frontend-components-skill/stargazers)

MIT License · [rushikeshsakharleofficial](https://github.com/rushikeshsakharleofficial)
