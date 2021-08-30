module GenerateDomainResult
	extend self

  PUBLIC_KEY = "AwEAAddt2AkLfYGKgiEZB5SmIF8EvrjxNMH6HtxWEA4RJ9Ao6LCWheg8".freeze
  IPV_4 = "127.0.0.1".freeze
  IPV_6_ONE = "::FFFF:192.0.2.1".freeze
  IPV_6_TWO = "2001:DB8::1".freeze

	def checking_data(hash)
		result = nil

    @domain_one = hash[:domain_one]
    @domain_two = hash[:domain_two]
    @random_nameserver = hash[:random_nameserver]

    @api_connector = hash[:api_connector]
    @action = hash[:action]
    @user = hash[:user]

		result = check_domain(domain_name: @domain_one, is_first_domain: true)
    result = check_domain(domain_name: @domain_two, is_first_domain: false) if result

		create_result(result)

    result
	end

  private

  def compare_data_of_domain(response:, is_first_domain:)
    flag_counter = 0

    private_contact_id = Rails.cache.read('priv_contact_id')
    org_contact_id = Rails.cache.read('org_contact_id')

    nameserver_hash_one = {
      "hostname"=>"ns1.#{@domain_one}", 
      "ipv4"=>[IPV_4],
      "ipv6"=>[IPV_6_ONE, IPV_6_TWO]
    }

    nameserver_hash_two = {
      "hostname"=>"ns2.#{@random_nameserver}", 
      "ipv4"=>[],
      "ipv6"=>[]
    }

    dnskey_hash = {
      "flags"=>0, 
      "protocol"=>3, 
      "alg"=>3, 
      "public_key"=>"#{PUBLIC_KEY}"
    }

    contact_private_hash =
      [
        {"code"=>"#{private_contact_id}", "type"=>"AdminDomainContact"},
        {"code"=>"#{private_contact_id}", "type"=>"TechDomainContact"}
      ]

    contact_org_hash =
      [
        {"code"=>"#{private_contact_id}", "type"=>"AdminDomainContact"},
        {"code"=>"#{org_contact_id}", "type"=>"TechDomainContact"}
      ]

    flag_counter +=1 if response["domain"]["name"] == (is_first_domain ? @domain_one : @domain_two)
    flag_counter +=1 if response["domain"]["registrant"] == (is_first_domain ? private_contact_id : org_contact_id)

    if is_first_domain
      flag_counter +=1 if response["domain"]["contacts"] == contact_private_hash
    else
      flag_counter +=1 if response["domain"]["contacts"] == contact_org_hash
    end

    flag_counter +=1 if response["domain"]["nameservers"].include? nameserver_hash_one if is_first_domain
    flag_counter +=1 if response["domain"]["nameservers"].include? nameserver_hash_two if is_first_domain
    flag_counter +=1 if response["domain"]["dnssec_keys"].include? dnskey_hash if is_first_domain



    return flag_counter == 6 if is_first_domain
    return flag_counter == 3
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
