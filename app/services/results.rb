class Results < ApiConnector
	PUSH_RESULT_ENDPOINT = "http://registry:3000/repp/v1/registrar/accreditation/push_results"

	def initialize(username:, password:)
		super
	end

	def push_results(params: nil)
    request = faraday_request(url: PUSH_RESULT_ENDPOINT, params: params)
    response = request.send(:get)
    JSON.parse(response.body)
  end
end