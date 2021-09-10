class CreateDomain < ApiConnector
	def initialize(username:, password:)
    super

	end

	def domain_endpoint
		base_url = ENV['BASE_URL']
		endpoint = ENV['CREATE_DOMAIN']

    base_url + endpoint
	end

	def headers
		 { 'Authorization' => "Basic #{@auth_token}",
       'AccreditationToken' => ENV['TEMPORARY_SECRET_KEY'] }
	end

	def create_domain
    request(url: domain_endpoint, headers: headers, method: :post, params: payload)
  end

  private

  def payload
    payload = {
      domain: {
        name: (0...12).map { (65 + rand(26)).chr }.join + '.ee',
        registrant: ENV['ACCR_CONTACT_CODE'],
        period: 1,
        period_unit: 'y'
      }
    }
  end
end
