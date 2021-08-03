require 'rails_helper'

RSpec.describe ApiConnector do |options|
  it "faraday request" do
		username = Faker::Lorem.word
		password = Faker::Lorem.word

		request_result = {
			message: "hello"
		}

		ApiConnector.any_instance.stub(:faraday_request)
			.and_return(request_result)

		api_connector = ApiConnector.new(username: username, password: password)
		result = api_connector
			.send(:faraday_request, { url: 'example.com', params: {} })
		
		expect(result[:message]).to eq("hello")
	end
end
