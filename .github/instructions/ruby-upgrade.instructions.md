---
applyTo: "ruby-upgrade-rubocop-zuno"
---

# Ruby Version Upgrade — rubocop-zuno

This document covers updating Ruby in the rubocop-zuno gem repository.

**Current version:** See `.ruby-version`

**Target:** Update to the latest stable Ruby version.

## Pre-requisites

The following must support the target Ruby version:

* [ruby-build](https://github.com/rbenv/ruby-build)
* [ruby/setup-ruby](https://github.com/ruby/setup-ruby)

## Files to Update

### 1. `.ruby-version` File

```bash
.ruby-version
```

### 2. `rubocop-zuno.gemspec`

Leave `required_ruby_version` unchanged unless dropping support for a minor series. It is the oldest Ruby consumers may use, not the development version.

### 3. Update `ruby/setup-ruby` Pin

Pin `.github/workflows/ci.yml` to the latest release commit, not `master`. The trailing comment records the tag:

```bash
TAG=$(curl -s "https://api.github.com/repos/ruby/setup-ruby/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
SHA=$(curl -s "https://api.github.com/repos/ruby/setup-ruby/commits/${TAG}" | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])")
perl -pi -e "s|ruby/setup-ruby\@[a-f0-9]{40}.*|ruby/setup-ruby\@${SHA} # ${TAG}|" .github/workflows/ci.yml
```

### 4. Regenerate Lockfile

Pass the latest stable Bundler version (`gem search '^bundler$' --remote`). Plain `--bundler` uses the newest installed Bundler, which may be a prerelease:

```bash
bundle update --bundler=X.Y.Z
```

## Testing

```bash
ruby -v # Must print the target version. An exported RBENV_VERSION overrides .ruby-version.
bundle install # Verify dependencies resolve
bundle exec rubocop # Lint code
bundle exec rspec # Run tests
```
