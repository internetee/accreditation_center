module GenerateInvoiceResult
	extend self

	def checking_data(hash)
    @action = hash[:action]
    @api_connector = hash[:api_connector]
    @user = hash[:user]

    result = nil

		result = check_invoice

		create_result(result)
    GeneratePracticeResult.start_counting(@user) if result
    
    result
	end

  private

  def check_invoice
    result = false

    response = @api_connector.get_invoice

    result = find_cancelled_invoice(response)

    result
  end

  def find_cancelled_invoice(response)
    current_date = Time.now
    flag = false
   
    response["invoices"].each do |invoice|
        flag = true if invoice["total"] == "24.0" && invoice["cancelled_at"].to_date == current_date.to_date
    end

    flag
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