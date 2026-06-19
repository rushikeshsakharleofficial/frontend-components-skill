# 21st.dev Category Priority Map

**Rule:** Search only matching categories. Never download random components.

## Priority 1: Hero / Animated Hero
- URL: https://21st.dev/community/components/s/hero
- Best for: Landing pages, SaaS, product intro, homepage first fold
- Examples: animated hero, typewriter effect, shape reveal, music reactive

## Priority 2: Landing Page
- URL: https://21st.dev/community/components/s/landing-page
- Best for: Full polished website sections, nav, backgrounds, feature blocks
- Examples: polished layout, background patterns, section templates

## Priority 3: Features / Bento Grid / Display Cards
- URL: https://21st.dev/community/components/s/features
- Best for: Product benefits, non-generic 3-card layouts
- Examples: bento grid, feature cards, display cards

## Priority 4: Calls to Action
- URL: https://21st.dev/community/components/s/call-to-action
- Best for: Conversion buttons, floating CTA, pricing modal, action bars
- Examples: floating CTA, action buttons, interactive CTA sections

## Priority 5: Testimonials
- URL: https://21st.dev/community/components/s/testimonials
- Best for: Trust, social proof sections, customer quotes
- Examples: testimonial carousel, testimonial grid, quote blocks

## Priority 6: Pricing Sections
- URL: https://21st.dev/community/components/s/pricing-sections
- Best for: SaaS pricing, service packages, quote plans
- Examples: pricing table, pricing modal, feature comparison

## Priority 7: AI Chat Components
- URL: https://21st.dev/community/components/s/ai-chat-components
- Best for: AI apps, chat UI, prompt input, assistant interface
- Examples: chat interface, message bubble, prompt input

## Priority 8: Framer Motion / Motion Components
- URL: https://21st.dev/community/components/s/framer-motion
- Best for: Scroll animation, reveal, parallax, premium movement
- Examples: scroll reveal, parallax section, motion effects

## Priority 9: Interactive Product Card
- URL: https://21st.dev/community/components/s/interactive-product-card
- Best for: Ecommerce, product catalog, B2B order cards
- Examples: product card, interactive product, shopping card

## Priority 10: Modal / Dialog
- URL: https://21st.dev/community/components/s/modal-dialog
- Best for: Checkout, login, inquiry forms, pricing modal
- Examples: modal dialog, quick order, checkout modal

## Priority 11: Buttons / Click Animation / Text Components
- URL: https://21st.dev/community/components/s/button
- Best for: Micro-polish, animated buttons, hover/click effects
- Examples: button variants, animated button, text gradient

## Priority 12: About / Avatar / Team
- URL: https://21st.dev/community/components/s/about-section
- Best for: Brand pages, people, founder, team, trust pages
- Examples: team section, avatar group, about layout

## Requirement-to-Category Matching

### Homepage
Required: hero, landing-page, features, calls-to-action, testimonials
Optional: pricing-sections (if SaaS)

### Ecommerce Website
Required: interactive-product-card, calls-to-action, modal-dialog
Optional: pricing-sections

### B2B Website
Required: hero, features, testimonials, calls-to-action, pricing-sections
Optional: landing-page

### AI Product
Required: ai-chat-components, prompt-input, framer-motion, hero, features
Skip: product-card, testimonials, pricing

### SaaS
Required: hero, landing-page, features, pricing-sections, calls-to-action, testimonials
Skip: product-card

### Dashboard / Internal Tool
Required: modal-dialog, buttons
Optional: none of the above (use UI library instead)

### Polish-Only (Low Priority Work)
Use: buttons, text-components, click-animation, framer-motion
Skip: landing, pricing, features, product-card

## Search Strategy

```
1. Classify user requirement (page type, business type, goal)
2. Match to categories above
3. Visit matching 21st.dev/s/* URLs only
4. Return top 3-5 candidates
5. Rank by: fit + installability + quality
6. Pick best candidate
```

## Do Not

- Download from multiple categories randomly
- Search all categories ("try everything")
- Recommend inspiration-only components as first choice
- Suggest paid/pro as solution
- Scrape paid/pro/premium-only components
