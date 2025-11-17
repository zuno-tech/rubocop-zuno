# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubocop/zuno/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 3.2"
  spec.authors = ["Zuno"]
  spec.description = "Base Rubocop settings for all Zuno Ruby projects"
  spec.email = ["developers@zuno.tech"]
  spec.homepage = "https://github.com/zuno-tech/rubocop-zuno"
  spec.license = "MIT"
  spec.metadata = {
    "rubygems_mfa_required" => "true"
  }
  spec.name = "rubocop-zuno"
  spec.summary = "Base Rubocop settings for all Zuno Ruby projects"
  spec.version = RuboCop::Zuno::VERSION

  spec.files = Dir[
    "*.yml",
    "config/*.yml",
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/**/*"
  ]
  spec.require_paths = ["lib"]

  # Locking rubocop versions so we can control the pending cops
  spec.add_dependency "rubocop", "1.81.7"
  spec.add_dependency "rubocop-factory_bot", "2.28.0"
  spec.add_dependency "rubocop-faker", "1.3.0"
  spec.add_dependency "rubocop-performance", "1.26.1"
  spec.add_dependency "rubocop-rails", "2.34.0"
  spec.add_dependency "rubocop-rake", "0.7.1"
  spec.add_dependency "rubocop-rspec", "3.8.0"
  spec.add_dependency "rubocop-rspec_rails", "2.32.0"
end
