require_relative './controller_macros'
require_relative './spec_test_helper'

RSpec.configure do |config|
	config.include Devise::Test::ControllerHelpers, type: :controller
	config.extend ControllerMacros, type: :controller
	config.include DeviseRequestSpecHelpers, type: :request
end