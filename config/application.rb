require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Assign
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
  end
end
