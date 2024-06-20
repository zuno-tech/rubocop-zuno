# frozen_string_literal: true

source "https://rubygems.org"

# Needed until Ruby 3.3.4 is released
# * https://github.com/ruby/net-pop/issues/26
# * https://github.com/ruby/ruby/pull/11006
gem "net-pop", github: "ruby/net-pop", tag: "v0.1.2"

gemspec

group :development do
  gem "rails", ">= 7.0.2.3", "< 8"
  gem "rake", "~> 13.2"
  gem "rspec", "~> 3.13"
  gem "simplecov", "~> 0.22"
end
