module GenerateTransferCodeResult
	extend self

	def checking_data(hash)
    @action = hash[:action]
    @api_connector = hash[:api_connector]
    @user = hash[:user]
    @domain_name = hash[:domain_name]
    @result = nil
    
    response = @api_connector.get_domain(@domain_name)

    if response["code"] == 1000 && response["domain"]["registrar"]["name"] != ENV["ACCR_REGISTRAR_NAME"]
      @result = true
    else
      @result = false
    end

    create_result(@result)
    @result
	end

  private

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