module GenerateRenewResult
	extend self

	def checking_data(hash)
    @action = hash[:action]
    @api_connector = hash[:api_connector]
    @user = hash[:user]
    @domain_one = hash[:domain_one]
    @domain_two = hash[:domain_two]
    @domain_one_expire_date = hash[:domain_one_expire_date]
    @domain_two_expire_date = hash[:domain_two_expire_date]

    result = nil
    
		result = check_domain(domain_name: @domain_one, is_first_domain: true)
    result = check_domain(domain_name: @domain_two, is_first_domain: false) if result

		create_result(result)

    result
	end

  private

  def compare_data_of_domain(response:, is_first_domain:)
    if is_first_domain
      equivalent = @domain_one_expire_date.to_date + 3.month
      expire_time = response["domain"]["expire_time"]

      return true if equivalent.to_date == expire_time.to_date
    else
      equivalent = @domain_one_expire_date.to_date + 6.month + 5.year
      expire_time = response["domain"]["expire_time"]

      return true if equivalent.to_date == expire_time.to_date
    end
    return false
  end

  def check_domain(domain_name:, is_first_domain:)
    result = false

    unless domain_name.nil?
      response = @api_connector.get_domain(domain_name)

      return result = compare_data_of_domain(response: response, is_first_domain: is_first_domain) if response["code"] == 1000
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