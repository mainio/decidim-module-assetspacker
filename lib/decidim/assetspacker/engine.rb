# frozen_string_literal: true

module Decidim
  module Assetspacker
    # This is an engine that customizes the assets packing in Decidim.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Assetspacker
      engine_name "decidim_assetspacker"

      initializer "decidim_assetspacker.add_customizations" do
        config.to_prepare do
          ActiveSupport.on_load :action_controller do
            include Decidim::Assetspacker::ReloadAssetPacks if Rails.env.start_with?("development")
          end

          # Add the customizations
          Shakapacker::Manifest.include(Decidim::Assetspacker::Compatibility::ManifestExtensions)
          Decidim::ContentSecurityPolicy.include(Decidim::Assetspacker::Compatibility::ContentSecurityPolicyExtensions)
        end
      end
    end
  end
end
