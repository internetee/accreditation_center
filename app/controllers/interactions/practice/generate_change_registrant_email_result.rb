module GenerateChangeRegistrantEmailResult
	extend self

	def checking_data(hash)
    @action = hash[:action]
    @api_connector = hash[:api_connector]
    @user = hash[:user]
    @domain_name = hash[:domain_name]
    verified = hash[:verified]

    result = nil

		result = check_domain(domain_name: @domain_name, verified: verified)

		create_result(result)

    result
	end

  private

  def compare_data_of_domain(response:, verified:)
    registrant_one_contact_id = Rails.cache.read('priv_contact_id')
    registrant_two_contact_id = Rails.cache.read('org_contact_id')
    registrant_code = response["domain"]["registrant"]

    if verified
      return true if registrant_code == registrant_one_contact_id
    else
      return true if registrant_code == registrant_two_contact_id
    end

    false
  end

  def check_domain(domain_name:, verified:)
    result = false

    unless domain_name.nil?
      response = @api_connector.get_domain(domain_name)

      return result = compare_data_of_domain(response: response, verified: verified) if response["code"] == 1000
    end

    result
  end

  def create_result(result)
    p = Practice.find_by(user: @user, action_name: @action)

    if p.nil?
      p = Practice.new
      p.user = @user
      p.result = result
      p.action_name = @action

      return p.save!
    end

    return if p.result

    p.update(result: result)
  end
end