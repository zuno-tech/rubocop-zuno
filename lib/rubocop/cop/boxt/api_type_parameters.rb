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
        API_MESSAGE = "Ensure each parameter has a type specified, e.g., `type: String`."
        ENTITY_MESSAGE = "Ensure each parameter has a type specified, e.g., `documentation: { type: String }`."

        def_node_matcher :param_declaration, <<-PATTERN
          (send nil? {:optional :requires :expose} _ $...)
        PATTERN

        def_node_search :param_with_type, <<-PATTERN
          (send nil? {:optional :requires} _ (hash <(pair (sym :type) $_) ...>))
        PATTERN

        def_node_search :entity_with_type_documentation, <<-PATTERN
          (send nil? :expose _ (hash <(pair (sym :documentation) (hash <(pair (sym :type) $_) ...>)) ...>))
        PATTERN

        def on_send(node)
          param_declaration(node) do
            next unless grape_api_class?(node) || grape_entity_class?(node)

            if grape_api_class?(node) && param_with_type(node).none?
              add_offense(node, message: API_MESSAGE)
            elsif grape_entity_class?(node) && entity_with_type_documentation(node).none?
              add_offense(node, message: ENTITY_MESSAGE)
            end
          end
        end

        private

        def grape_api_class?(node)
          grape_parent_class?(node, "Grape::API")
        end

        def grape_entity_class?(node)
          grape_parent_class?(node, "Grape::Entity")
        end

        def grape_parent_class?(node, class_name)
          node.each_ancestor(:class).any? do |ancestor|
            ancestor.children.any? do |child|
              child&.source == class_name
            end
          end
        end
      end
    end
  end
end
