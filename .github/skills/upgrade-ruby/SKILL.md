---
name: upgrade-ruby
description: 'Update Ruby version in the rubocop-zuno gem repo. Run after /upgrade-ruby-setup has checked out main and created the upgrade branch. Only .ruby-version needs updating — CI reads it dynamically.'
argument-hint: '<old-version> <new-version> (e.g. 4.0.2 4.1.0)'
---

# Upgrade Ruby — rubocop-zuno

## Prerequisites
Run `/upgrade-ruby-setup` first to install Ruby via rbenv and create the upgrade branch.

## Required Inputs
- **Old version** (e.g. `4.0.2`)
- **New version** (e.g. `4.1.0`)

---

## Procedure

### 1. Update `.ruby-version`

File: `.ruby-version` — set to `<new-version>` (bare version string only).

### 2. Update `ruby/setup-ruby` pin

File: `.github/workflows/ci.yml` — update to the latest `v1` SHA:

```bash
LATEST=$(curl -s "https://api.github.com/repos/ruby/setup-ruby/commits/master" | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])")
sed -i '' "s#ruby/setup-ruby@[a-f0-9]*#ruby/setup-ruby@${LATEST}#g" .github/workflows/ci.yml
```

### 3. Re-bundle

```bash
bundle update --bundler
bundle install
```

### 4. Verify

```bash
grep -r "<old-version>" \
	--include="*.rb" --include="*.yml" --include=".ruby-version" \
	.
```

### Files that do NOT need changes

- `Gemfile` — no Ruby pin
- `rubocop-zuno.gemspec` — floor constraint only
- `.github/workflows/ci.yml` — reads `.ruby-version` dynamically via `ruby/setup-ruby`
