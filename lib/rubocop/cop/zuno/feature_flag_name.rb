# frozen_string_literal: true

module RuboCop
  module Cop
    module Zuno
      class FeatureFlagName < RuboCop::Cop::Base
        MSG = "Use only lowercase letters, numbers, and underscores for feature flag names " \
              "(e.g., feature_flag instead of feature-flag)"

        VALID_FLAG_NAME = /\A[a-z0-9_]+\z/

        # Matches a block with `task :rollout` or `task rollout: ...` as the send
        def_node_matcher :rollout_task_block?, <<~PATTERN
          (block
            (send nil? :task {(sym :rollout) (hash (pair (sym :rollout) ...))})
            args
            _
          )
        PATTERN

        def on_array(node)
          return unless processed_source.file_path&.end_with?("rollout.rake")
          return unless node.each_ancestor(:block).any? { |block| rollout_task_block?(block) }

          check_flag_names(node)
        end

        private

        def check_flag_names(array_node)
          array_node.children.each do |element|
            next unless element.str_type?

            add_offense(element) unless element.value.match?(VALID_FLAG_NAME)
          end
        end
      end
    end
  end
end
