# frozen_string_literal: true

require "rubocop"

require_relative "rubocop/boxt"
require_relative "rubocop/boxt/version"
require_relative "rubocop/boxt/inject"

RuboCop::Boxt::Inject.defaults!

require_relative "rubocop/cop/boxt_cops"
