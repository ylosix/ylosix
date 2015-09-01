require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ecommerce
  Version = '0.1'.freeze

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.active_job.queue_adapter = :inline
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:es, :en]

    config.assets.precompile += %w( ckeditor/* )

    # TODO env vars
    DOMAIN_HOST = 'demo.ylosix.com'
    MAIN_EMAIL = 'admin@ylosix.com'
  end
end
