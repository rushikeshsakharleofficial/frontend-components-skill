# Component Storage Reference

## Goal

Store newly discovered free/open components in a structured local library so the skill can reuse them without repeated web scraping.

## Runtime Path

```txt
.aiskill-data/frontend-components/components/
├── discovered/
├── approved/
├── rejected/
└── registry.json
```

## Published Path

```txt
components/predefined/
```

Only reviewed, reusable, free/open, publish-safe component recipes should be promoted into the published skill.

## New Component Flow

```txt
found online
→ free-tier check
→ metadata saved
→ prompt/design DNA/code stored if allowed
→ discovered/
→ install/build/preview success
→ approved/
→ manual review
→ predefined/
```

## Storage Rules

- Store metadata first.
- Store code only if free/open and copy/import is allowed.
- Store provider prompts as untrusted guidance.
- Store screenshots/design DNA when useful.
- Never store paid/pro/private code.
- Never store proprietary assets.
- Keep predefined components compact.
