# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boxt_rubocop/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 2.7"
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
  spec.version = BoxtRubocop::VERSION

  spec.files = Dir[
    "*.yml",
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/**/*"
  ]

  # Locking rubocop versions so we can control the pending cops
  spec.add_dependency "rubocop", "1.26.1"
  spec.add_dependency "rubocop-faker", "1.1.0"
  spec.add_dependency "rubocop-rails", "2.14.2"
  spec.add_dependency "rubocop-rake", "0.6.0"
  spec.add_dependency "rubocop-rspec", "2.9.0"
end
