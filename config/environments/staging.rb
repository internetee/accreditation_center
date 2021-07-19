require_relative 'production'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  require 'syslog/logger'
  config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new(ENV['app_name'] || 'accreditation'))

	# Enable stdout logger
config.logger = Logger.new(STDOUT)

# Set log level
config.log_level = :ERROR

end
