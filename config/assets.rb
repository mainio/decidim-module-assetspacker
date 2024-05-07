# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Webpacker.register_path("#{base_path}/app/packs", prepend: true)
Decidim::Webpacker.register_entrypoints(
  decidim_core_esbuild: "#{base_path}/app/packs/entrypoints/decidim_core_esbuild.js"
)
