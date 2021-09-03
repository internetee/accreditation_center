require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AccreditationCenterV2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoloader = :zeitwerk
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers', 'interactions', '**/')]
    config.autoload_paths += %W(#{config.root}/lib)
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.middleware.use Rack::Deflater
  end

  Rails.application.config.assets.configure do |env|
    env.export_concurrent = false
  end
end
