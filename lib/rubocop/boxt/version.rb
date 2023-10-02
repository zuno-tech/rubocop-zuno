# frozen_string_literal: true

module RuboCop
  module Boxt
    VERSION = File.read(File.join(File.dirname(__FILE__), "../../../VERSION")).split("\n").first
  end
end
