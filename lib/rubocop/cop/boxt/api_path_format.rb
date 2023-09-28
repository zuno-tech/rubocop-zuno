# frozen_string_literal: true

module RuboCop
  module Cop
    module Boxt
      # Clients expect to interface with our API using kebab-case.
      #
      # This cop ensures that our API paths are formatted using the correct case.
      #
      # Underscores are acceptable in path variables (e.g. "/path/:path_id/update")
      #
      # API style guide: https://github.com/boxt/boxt-docs/blob/main/coding-styles/api.md#camel-cased-endpoints
      #
      # @example
      #   # bad
      #   post "/admin/orders/:order_id/contact_details/update"
      #   get  "/installation_days"
      #   namespace "password_resets"
      #   namespace :password_resets
      #
      #   # good
      #   post "/admin/orders/:order_id/contact-details/update"
      #   get  "/installation-days"
      #   namespace "password-resets"
      #
      class ApiPathFormat < Base
        def_node_matcher :path_defining_method_with_string_path, <<~PATTERN
          (send nil? {:post | :get | :namespace} (:str $_))
        PATTERN

        def_node_matcher :namespace_with_symbol, <<~PATTERN
          (send nil? :namespace (:sym $_))
        PATTERN

        MSG = "Use kebab-case for the API path"

        def on_send(node)
          path_defining_method_with_string_path(node) do |path|
            add_offense(node) if path_name_does_not_follow_kebab_case?(path)
          end

          namespace_with_symbol(node) do |path|
            add_offense(node) if path.to_s.include?("_")
          end
        end

        private

        def path_name_does_not_follow_kebab_case?(path)
          path.split("/").any? { |split| !split.start_with?(":") && split.include?("_") }
        end
      end
    end
  end
end
