require 'faraday'

class ApiConnector
  attr_reader :auth_token

	POLL_MESSAGE_ENDPOINT = "http://registry:3000/repp/v1/registrar/accreditation_info"

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
  end

	def sign_in(params: nil)
    request = faraday_request(url: POLL_MESSAGE_ENDPOINT, params: params)
    response = request.send(:get)
    JSON.parse(response.body)
  end

  private

  def generate_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end

  def faraday_request(url:, params: {})
    Faraday.new(
      url: url,
      headers: { 'Authorization' => "Basic #{@auth_token}" },
      params: params,
			ssl: { verify: false}
    )
  end
end