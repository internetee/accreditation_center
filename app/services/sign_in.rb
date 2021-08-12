class SignIn < ApiConnector

	def initialize(username:, password:)
		super
	end

	def signin_endpoint
		ENV['BASE_URL'] + ENV['GET_INFO'] 
	end

	def headers
		 { 'Authorization' => "Basic #{@auth_token}" }
	end

	def sign_in(params: nil)
		p "=============="
		p signin_endpoint
		p "=============="
		request(url: signin_endpoint, headers: headers, method: 'get')
  end
end
