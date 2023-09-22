# frozen_string_literal: true

require "boxt_rubocop/version"

# Require all custom cops defined in api/lib/rubocop/cop/**/*.rb
Dir[File.join(__dir__, "rubocop", "cop", "**", "*.rb")].sort.each { |file| require file }

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
