class Results < ApiConnector
	PUSH_RESULT_ENDPOINT = "http://registry:3000/repp/v1/registrar/accreditation/push_results"
	TEMPORARY_SECRET_KEY = 'temporary-secret-key'

	def initialize; end

	def headers
		 { 'Authorization' => "Basic #{ENV['TEMPORARY_SECRET_KEY']}" }
	end

	def post_params
		{
			accreditation_result: {
				username: "Oleg",
				result: "true"
			}
		}
	end

	def push_results(params: nil)
    	request(url: PUSH_RESULT_ENDPOINT, headers: headers, method: :post, params: post_params)
  end
end