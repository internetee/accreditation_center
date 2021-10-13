require 'faraday'

class ApiConnector
  attr_reader :auth_token

  def initialize(username:, password:)
    @auth_token = generate_token(username: username, password: password)
  end

  private

  def request(url:, method:, headers:, params: nil, ssl: nil)
    request = faraday_request(url: url, headers: headers, params: params, ssl: ssl)
    response = request.send(method)
    JSON.parse(response.body)
  end

  def generate_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end

  def faraday_request(url:, headers:, params: {}, ssl:)
    Faraday.new(
      url: url,
      headers: headers,
      params: params,
      ssl: ssl
    )
  end
end
