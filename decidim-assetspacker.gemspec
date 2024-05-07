# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "decidim/assetspacker/version"

Gem::Specification.new do |spec|
  spec.name = "decidim-assetspacker"
  spec.version = Decidim::Assetspacker.version
  spec.required_ruby_version = ">= 3.1"
  spec.authors = ["Antti Hukkanen"]
  spec.email = ["antti.hukkanen@mainiotech.fi"]
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.summary = "Faster way to build Decidim assets."
  spec.description = "Provides a custom assets packer based on esbuild to improve performance."
  spec.homepage = "https://github.com/mainio/decidim-module-assetspacker"
  spec.license = "AGPL-3.0"

  spec.bindir = "exe"
  spec.executables = ["decidimpack"]

  spec.files = Dir[
    "{app,config,exe,lib}/**/*",
    "LICENSE-AGPLv3.txt",
    "Rakefile",
    "README.md"
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency "decidim-core", Decidim::Assetspacker.decidim_version

  spec.add_development_dependency "decidim-dev", Decidim::Assetspacker.decidim_version
end
