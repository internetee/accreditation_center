class GetDomain < ApiConnector
	def initialize(token)
		@token = token
	end

	def domain_endpoint
		base_url = ENV['BASE_URL']
		endpoint = ENV['GET_DOMAIN'] 

		base_url + endpoint
	end

	def headers
		 { 'Authorization' => "Basic #{@token}" }
	end

	def get_domain(domain_name)
    	request(url: domain_endpoint + domain_name.gsub(/\s+/, ""), headers: headers, method: :get, params: nil)
  end
end