require 'faraday'

class ApiConnector
  attr_reader :auth_token

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
  end

  private

  def request(url:, method:, headers:, params: nil)
    request = faraday_request(url: url, headers: headers, params: params)
    response = request.send(method)
    JSON.parse(response.body)
  end

  def generate_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end

  # { 'Authorization' => "Basic #{@auth_token}" }
  def faraday_request(url:, headers:, params: {})
    Faraday.new(
      url: url,
      headers: headers,
      params: params,
      ssl: { verify: false}
    )
  end
end
