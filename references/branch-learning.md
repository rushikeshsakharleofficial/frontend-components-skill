# Branch-Based Component Learning

This is a public-repo-safe optional feature.

It is disabled by default. When enabled, approved free/open components discovered during use can be copied into `references/component-cache/` and pushed to separate review branches.

## Default

Disabled.

Enable with:

```bash
scripts/setup-component-sync.sh
```

## Branch Pattern

```txt
learning/frontend-components/<source>/<component-slug>-<yyyymmdd-hhmm>
```

## Merge Policy

- No direct `main` push by default.
- No auto-merge.
- No force-push.
- User reviews branch.
- User merges only if component quality is good and safe.
- Paid/pro/private/restricted components are blocked.
- Runtime `.aiskill-data/` is not published.
