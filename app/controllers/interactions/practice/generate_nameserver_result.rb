module GenerateNameserverResult
	extend self

	def checking_data(hash)
		result = nil

    @domain_one = hash[:domain_one]
    @domain_two = hash[:domain_two]
    @random_nameserver_one = hash[:random_nameserver_one]
    @random_nameserver_two = hash[:random_nameserver_two]
    @random_nameserver_two = hash[:random_nameserver_two]

    @api_connector = hash[:api_connector]
    @action = hash[:action]
    @user = hash[:user]

		result = check_namespace(domain_name: @domain_one, is_first_domain: true)
    result = check_namespace(domain_name: @domain_two, is_first_domain: false) if result

		create_result if result

    result
	end

  private

    def check_namespace(domain_name:, is_first_domain:)
    result = nil

    unless domain_name.nil?
      response = @api_connector.get_domain(domain_name)

      return result = compare_data_of_domain(response: response, is_first_domain: is_first_domain) if response["code"] == 1000
      return false
    end

    result
  end

  def compare_data_of_domain(response:, is_first_domain:)
    flag_counter = 0

    private_contact_id = Rails.cache.read('priv_contact_id')
    org_contact_id = Rails.cache.read('org_contact_id')

    nameserver_hash_one = {
      "hostname"=>"ns1.#{@random_nameserver_one}", 
      "ipv4"=>["0.0.0.1"],
      "ipv6"=>[]
    }

    nameserver_hash_two = {
      "hostname"=>"ns2.#{@random_nameserver_two}", 
      "ipv4"=>[],
      "ipv6"=>["2001:DB8::1"]
    }

    nameserver_hash_three = {
      "hostname"=>"ns3.#{@domain_two}", 
      "ipv4"=>["0.54.0.62"],
      "ipv6"=>[]
    }

    flag_counter +=1 if response["data"]["domain"]["nameservers"].include? nameserver_hash_one if is_first_domain

    flag_counter +=1 if response["data"]["domain"]["nameservers"].include? nameserver_hash_two unless is_first_domain
    flag_counter +=1 if response["data"]["domain"]["nameservers"].include? nameserver_hash_three unless is_first_domain

    return flag_counter == 1 if is_first_domain
    return flag_counter == 2
  end

  def create_result
    p = Practice.new
    p.user = @user
    p.result = true
    p.action_name = @action

    p.save!
  end
end
