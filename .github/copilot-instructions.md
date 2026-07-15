# GitHub Copilot Instructions

## Project-Specific Guidelines

### Ruby Upgrades

Ruby version updates are coordinated across the entire workspace. When upgrading Ruby in this gem:

1. **Reference project-specific workflow** in [ruby-upgrade.instructions.md](instructions/ruby-upgrade.instructions.md)
2. Update `.ruby-version` in this gem
3. Update `rubocop-zuno.gemspec` `required_ruby_version` constraint
4. Run tests locally before pushing

**Current Ruby version:** See `.ruby-version`
