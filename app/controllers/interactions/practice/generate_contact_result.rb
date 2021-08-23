module GenerateContactResult
	extend self

	def checking_data(hash)
		result = nil

    org_contact_id = hash[:org_contact_id]
    priv_contact_id = hash[:priv_contact_id]

    @api_connector = hash[:api_connector]
    @action = hash[:action]
    @user = hash[:user]
    @priv_name = hash[:priv_name]
    @org_name = hash[:org_name]

		result = check_private_contact(priv_contact_id)
    result = check_org_contact(org_contact_id) if result

		create_result if result

    result
	end

  private

  def compare_data_of_priv_contact(response)
    flag_counter = 0

    flag_counter +=1 if response["data"]["name"] == @priv_name
    flag_counter +=1 if response["data"]["email"] == "#{@priv_name}@eesti.ee" 
    flag_counter +=1 if response["data"]["phone"] == "+372.51234567" 
    flag_counter +=1 if response["data"]["ident"]["type"] == "priv" 
    flag_counter +=1 if response["data"]["ident"]["code"] == "49708260212" 

    return flag_counter == 5
  end

  def compare_data_of_org_contact(response)
    flag_counter = 0

    flag_counter +=1 if response["data"]["name"] == @org_name
    flag_counter +=1 if response["data"]["email"] == "#{@org_name}@eesti.ee" 
    flag_counter +=1 if response["data"]["phone"] == "+372.51200167" 
    flag_counter +=1 if response["data"]["ident"]["type"] == "org" 
    flag_counter +=1 if response["data"]["ident"]["code"] == "12345678" 

    return flag_counter == 5
  end

  def create_result
    p = Practice.new
    p.user = @user
    p.result = true
    p.action_name = @action

    p.save!
  end

  def check_private_contact(priv_id)
    result = nil
    unless priv_id.nil?
      response = @api_connector.get_contact(priv_id)

      return result = compare_data_of_priv_contact(response) if response["code"] == 1000
      return false
    end

    result
  end

  def check_org_contact(org_id)
    result = nil
    unless org_id.nil?
      response = @api_connector.get_contact(org_id)

      return result = compare_data_of_org_contact(response) if response["code"] == 1000
      return false
    end
    result
  end
end