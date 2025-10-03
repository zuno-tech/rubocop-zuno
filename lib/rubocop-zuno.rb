# frozen_string_literal: true

require "rubocop"

require_relative "rubocop/zuno"
require_relative "rubocop/zuno/version"
require_relative "rubocop/zuno/inject"

RuboCop::Zuno::Inject.defaults!

require_relative "rubocop/cop/zuno_cops"
