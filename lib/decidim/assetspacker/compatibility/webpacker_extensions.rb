# frozen_string_literal: true

# Provides customizations to the core classes during assets packer runtime when
# the whole Rails environment is not typically loaded.

require "active_support/concern"
require_relative "tailwind_instance_extensions"

Decidim::Assets::Tailwind::Instance.include(Decidim::Assetspacker::Compatibility::TailwindInstanceExtensions)
