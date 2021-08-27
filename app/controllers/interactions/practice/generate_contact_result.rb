module GenerateContactResult
	extend self

  PHONE_PRIV_NUMBER = "+372.51234567".freeze
  PHONE_ORG_NUMBER = "+372.51200167".freeze
  PRIV_IDENT_CODE = "49708260212".freeze
  ORG_BUSSINESS_CODE = "12345678".freeze

	def checking_data(hash)
		result = nil

    org_contact_id = hash[:org_contact_id]
    priv_contact_id = hash[:priv_contact_id]

    @api_connector = hash[:api_connector]
    @action = hash[:action]
    @user = hash[:user]
    @priv_name = hash[:priv_name]
    @org_name = hash[:org_name]

		result = check_contact(cont_id: priv_contact_id, is_priv: true)
    result = check_contact(cont_id: org_contact_id, is_priv: false) if result

		create_result if result

    result
	end

  private

  def compare_data_of_contact(response:, is_priv:) 
    flag_counter = 0

    flag_counter +=1 if response["contact"]["name"] == (is_priv ? @priv_name : @org_name)
    flag_counter +=1 if response["contact"]["email"] == (is_priv ? "#{@priv_name}@eesti.ee" : "#{@org_name}@eesti.ee") 
    flag_counter +=1 if response["contact"]["phone"] == (is_priv ? PHONE_PRIV_NUMBER : PHONE_ORG_NUMBER) 
    flag_counter +=1 if response["contact"]["ident"]["type"] == (is_priv ? "priv" : "org") 
    flag_counter +=1 if response["contact"]["ident"]["code"] == (is_priv ? PRIV_IDENT_CODE : ORG_BUSSINESS_CODE)

    Rails.cache.write('priv_contact_id', response["contact"]["id"]) if is_priv
    Rails.cache.write('org_contact_id', response["contact"]["id"]) unless is_priv

    return flag_counter == 5
  end

  def check_contact(cont_id:, is_priv:)
    result = nil
    unless cont_id.nil?
      response = @api_connector.get_contact(cont_id)

      return result = compare_data_of_contact(response: response, is_priv: is_priv) if response["code"] == 1000
      return false
    end

    result
  end

  def create_result
    p = Practice.new
    p.user = @user
    p.result = true
    p.action_name = @action

    p.save!
  end
end
