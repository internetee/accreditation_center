class Results < ApiConnector
	PUSH_RESULT_ENDPOINT = "http://registry:3000/repp/v1/registrar/accreditation/push_results"
	TEMPARY_SECRET_KEY = 'tempary-secret-key'

	def initialize(username:, password:)
		super
	end

	def push_results(params: nil)
    	request(url: PUSH_RESULT_ENDPOINT, method: :get, params: {})
  end
end