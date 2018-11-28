if ENV['GENERATE_TEST_COVERAGE_REPORT']
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    @original_exams_config = Rails.configuration.exams
  end

  teardown do
    Rails.configuration.exams = @original_exams_config
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include AbstractController::Translation
end
