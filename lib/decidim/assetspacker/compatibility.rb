# frozen_string_literal: true

module Decidim
  module Assetspacker
    # A compatibility layer that hooks into the old assets packer to provide the
    # assets through this module instead of the old one.
    module Compatibility
      autoload :ManifestExtensions, "decidim/assetspacker/compatibility/manifest_extensions"
      autoload :TailwindInstanceExtensions, "decidim/assetspacker/compatibility/tailwind_instance_extensions"
      autoload :ContentSecurityPolicyExtensions, "decidim/assetspacker/compatibility/content_security_policy_extensions"
    end
  end
end
