# frozen_string_literal: true

module RuboCop
  module Cop
    module Boxt
      # This cop ensures that each parameter in a Grape API has a type specified.
      #
      # @example
      #   # bad
      #   requires :name
      #   optional :age
      #
      #   # good
      #   requires :name, type: String
      #   optional :age, type: Integer
      #
      class ApiTypeParameters < Cop
        MSG = "Ensure each parameter has a type specified, e.g., `type: String`."

        def_node_matcher :param_declaration, <<-PATTERN
          (send nil? {:optional :requires} _ $...)
        PATTERN

        def on_send(node)
          param_declaration(node) do |args|
            next unless grape_api_class?(node)
            next if type_specified?(args)

            add_offense(node, message: MSG)
          end
        end

        private

        def grape_api_class?(node)
          node.each_ancestor(:class).any? do |ancestor|
            ancestor.children.any? do |child|
              child&.source == "Grape::API"
            end
          end
        end

        def type_specified?(args)
          return false if args.empty?

          args.any? do |arg|
            arg.type == :hash && arg.children.any? do |pair|
              pair.type == :pair && pair.children[0].source == "type"
            end
          end
        end
      end
    end
  end
end
