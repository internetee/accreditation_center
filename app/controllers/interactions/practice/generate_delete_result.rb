module GenerateDeleteResult
	extend self

	def checking_data(hash)
    @action = hash[:action]
    @api_connector = hash[:api_connector]
    @user = hash[:user]
    @domain_name = hash[:domain_name]

    result = nil

		result = check_domain(domain_name: @domain_name)

		create_result(result)

    result
	end

  private

  def check_domain(domain_name:)
    result = false

    unless domain_name.nil?
      response = @api_connector.get_domain(domain_name)

      return true if response["domain"]["statuses"].include? "pendingDelete"
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