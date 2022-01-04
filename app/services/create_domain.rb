require 'openssl'
require 'net/http'
require 'json'

class CreateDomain < ApiConnector
  if Rails.env.test?
    SSL_OPTIONS = nil.freeze
  else
    SSL_OPTIONS = {
      client_cert: OpenSSL::X509::Certificate.new(File.read(ENV['CLIENT_CERTS_PATH'])),
      client_key:  OpenSSL::PKey::RSA.new(File.read(ENV['CLIENT_KEY_PATH']), ENV['CLIENT_PASSWORD'])
    }.freeze
  end

	def initialize(username:, password:)
    super

	end

	def domain_endpoint
		base_url = ENV['BASE_REPP_URL']
		endpoint = ENV['CREATE_DOMAIN']

    base_url + endpoint
	end

	def headers
		 { 'Authorization' => "Basic #{@auth_token}",
       'AccreditationToken' => ENV['TEMPORARY_SECRET_KEY'] }
	end

	def create_domain
    request(url: domain_endpoint, headers: headers, method: :post, params: payload, ssl: SSL_OPTIONS)
  end

  private

  def payload
    payload = {
      domain: {
        name: (0...12).map { (65 + rand(26)).chr }.join + '.ee',
        registrant: ENV['ACCR_CONTACT_CODE'],
        period: 1,
        period_unit: 'y',
        'admin_contacts': [
          ENV['ACCR_CONTACT_CODE']
        ],
      }
    }
  end
end
