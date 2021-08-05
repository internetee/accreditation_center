class SignIn < ApiConnector
	POLL_MESSAGE_ENDPOINT = "http://registry:3000/repp/v1/registrar/accreditation/get_info"

	def initialize(username:, password:)
		super
	end

	def sign_in(params: nil)
		request(url: POLL_MESSAGE_ENDPOINT, method: 'get')
  end
end
