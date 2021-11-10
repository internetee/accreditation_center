class GetInvoice < ApiConnector
	attr_reader :token

	def initialize(token)
		@token = token
	end

	def invoce_endpoint
		base_url = ENV['BASE_URL']
		endpoint = ENV['GET_INVOICES'] 

		base_url + endpoint
	end

	def headers
		 { 'Authorization' => "Basic #{@token}" }
	end

	def get_invoice
    	request(url: invoce_endpoint, headers: headers, method: :get, params: nil)
  end
end
