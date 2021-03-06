require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:en, :ru]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.paperclip_defaults = {
      storage: :s3,
      s3_region: ENV["AWS_S3_REGION"],
      s3_credentials: {
        s3_host_name: ENV["AWS_S3_HOST_NAME"],
        bucket: ENV["AWS_S3_BUCKET"],
        access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
      }
    }
    config.action_mailer.smtp_settings = {
      address:              'smtp.mailgun.org',
      port:                 587,
      domain:               'sandbox6167335e4e594a0a95c9056665d6c16b.mailgun.org',
      user_name:            ENV["MAILGUN_USR"],
      password:             ENV["MAILGUN_PASS"],
      authentication:       'plain',
      enable_starttls_auto: true
    }
  end
end
