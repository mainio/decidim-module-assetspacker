# frozen_string_literal: true

require "decidim/assetspacker/version"
require "decidim/assetspacker/engine"

module Decidim
  module Assetspacker
    autoload :Compatibility, "decidim/assetspacker/compatibility"
    autoload :Packer, "decidim/assetspacker/packer"
  end
end
