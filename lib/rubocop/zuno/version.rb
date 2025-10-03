# frozen_string_literal: true

module RuboCop
  module Zuno
    VERSION = File.read(File.join(File.dirname(__FILE__), "../../../VERSION")).split("\n").first
  end
end
