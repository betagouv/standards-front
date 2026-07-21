require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TechEvaluation
  class Application < Rails::Application
    config.i18n.default_locale = :fr
    config.i18n.fallbacks = [ :en ]

    require "dsfr/components"
    require "dsfr/assets"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks models types])

    # to_prepare runs on every development reload (but once in
    # production and test) : this is where we can load our extensions
    # to `espace_membre-ruby` after the gem's code is loaded by
    # triggering the ActiveRecord::Base hook which it relies on to
    # load its files.
    Rails.application.config.to_prepare do
      ActiveRecord::Base # force the gem's `ActiveSupport.on_load(:active_record)` hook

      load Rails.root.join("lib/models/espace_membre/startup.rb")
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
