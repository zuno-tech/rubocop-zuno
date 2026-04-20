# frozen_string_literal: true

require "lint_roller"

module RuboCop
  module Zuno
    # A plugin that integrates RuboCop Zuno with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: "rubocop-zuno",
          version: RuboCop::Zuno::VERSION,
          homepage: "https://github.com/zuno-tech/rubocop-zuno",
          description: "Base RuboCop settings for all Zuno Ruby projects"
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: CONFIG_DEFAULT
        )
      end
    end
  end
end
