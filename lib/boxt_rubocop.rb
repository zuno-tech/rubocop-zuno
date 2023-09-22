# frozen_string_literal: true

require "boxt_rubocop/version"

module BoxtRubocop
  module_function

  ##
  # Provide a root path helper for the gem root dir
  #
  # Returns Pathname
  def root
    Pathname.new(File.dirname(__dir__))
  end
end
