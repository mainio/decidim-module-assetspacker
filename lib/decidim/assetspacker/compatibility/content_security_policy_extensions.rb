# frozen_string_literal: true

module Decidim
  module Assetspacker
    module Compatibility
      module ContentSecurityPolicyExtensions
        extend ActiveSupport::Concern

        included do
          private

          def append_development_directives
            return unless Rails.env.development?

            host = "localhost"
            port = 3035

            append_csp_directive("connect-src", "http://#{host}:#{port}")
          end
        end
      end
    end
  end
end
