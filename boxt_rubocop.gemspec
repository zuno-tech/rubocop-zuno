# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubocop/boxt/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 3.0"
  spec.authors = ["Boxt"]
  spec.description = "Base Rubocop settings for all Boxt Ruby projects"
  spec.email = ["developers@boxt.co.uk"]
  spec.homepage = "https://github.com/boxt/boxt_rubocop"
  spec.license = "MIT"
  spec.metadata = {
    "rubygems_mfa_required" => "true"
  }
  spec.name = "boxt_rubocop"
  spec.summary = "Base Rubocop settings for all Boxt Ruby projects"
  spec.version = RuboCop::Boxt::VERSION

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
  spec.add_dependency "rubocop", "1.70.0"
  spec.add_dependency "rubocop-factory_bot", "2.26.1"
  spec.add_dependency "rubocop-faker", "1.2.0"
  spec.add_dependency "rubocop-performance", "1.23.1"
  spec.add_dependency "rubocop-rails", "2.29.0"
  spec.add_dependency "rubocop-rake", "0.6.0"
  spec.add_dependency "rubocop-rspec", "3.4.0"
end
