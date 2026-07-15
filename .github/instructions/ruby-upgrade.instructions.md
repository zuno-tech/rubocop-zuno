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

Update `required_ruby_version` constraint:

```ruby
spec.required_ruby_version = ">= X.Y.Z"  # Update as needed
```

### 3. Update `ruby/setup-ruby` SHA

Update the SHA in `.github/workflows/ci.yml`:

    LATEST=$(curl -s "https://api.github.com/repos/ruby/setup-ruby/commits/master" | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])")
    sed -i.bak "s#ruby/setup-ruby@[a-f0-9]*#ruby/setup-ruby@${LATEST}#g" .github/workflows/ci.yml
    rm .github/workflows/ci.yml.bak

### 4. Regenerate Lockfile

```bash
bundle update --bundler
```

## Testing

```bash
bundle install # Verify dependencies resolve
bundle exec rubocop # Lint code
bundle exec rspec # Run tests
```
