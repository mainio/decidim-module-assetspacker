# frozen_string_literal: true

module Decidim
  module Assetspacker
    module Compatibility
      module TailwindInstanceExtensions
        extend ActiveSupport::Concern

        included do
          private

          def app_path
            @app_path ||=
              if defined?(Rails)
                Rails.application.root
              elsif defined?(Decidim::Assetspacker::Packer)
                Decidim::Assetspacker::Packer.instance.root
              else
                # This is used when Rails is not available from the webpacker binstubs
                File.expand_path(".", Dir.pwd)
              end
          end
        end
      end
    end
  end
end
