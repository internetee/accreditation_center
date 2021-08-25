class GetContact < ApiConnector
	def initialize(token)
		@token = token
	end

	def contact_endpoint
		base_url = ENV['BASE_URL']
		endpoint = ENV['GET_CONTACT'] 

		base_url + endpoint
	end

	def headers
		 { 'Authorization' => "Basic #{@token}" }
	end

	def get_contact(contact_id)
    	request(url: contact_endpoint + contact_id.gsub(/\s+/, ""), headers: headers, method: :get, params: nil)
  end
end