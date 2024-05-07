# frozen_string_literal: true

module Decidim
  module Assetspacker
    module Compatibility
      module ManifestExtensions
        extend ActiveSupport::Concern

        included do
          def lookup!(name)
            # Few changes needed in the decidim_core.js regarding the global
            # imports which is why we use a custom entrypoint to replace the
            # default entrypoint.
            name = "decidim_core_esbuild.js" if name == "decidim_core.js"

            path = Decidim::Assetspacker::Packer.instance.path_to(name)
            raise Shakapacker::Manifest::MissingEntryError, "Assets packer cannot find file: #{name}" unless path

            path
          end

          def lookup_pack_with_chunks!(name, type:)
            ext =
              case type
              when :stylesheet
                "css"
              when :javascript
                "js"
              else
                type.to_s
              end

            lookup!("#{name}.#{ext}")
          end
        end
      end
    end
  end
end
