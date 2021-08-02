require 'faraday'

class ApiConnector
  attr_reader :auth_token

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
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
