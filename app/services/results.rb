class Results < ApiConnector
  attr_reader :username

	def initialize(username)
		@username = username
	end

	def push_endpoint
		base_url = ENV['BASE_PRODUCTION_URL']
		base_url = ENV['BASE_URL'] if Rails.env.staging?
		endpoint = ENV['PUSH_RESULT'] 

		base_url + endpoint
	end

	def headers
		 { 'Authorization' => "Basic #{ENV['TEMPORARY_SECRET_KEY']}" }
	end

	def post_params
		{
			accreditation_result: {
				username: "#{@username}",
				result: "true"
			}
		}
	end

	def push_results(params: nil)
    	request(url: push_endpoint, headers: headers, method: :post, params: post_params)
  end
end