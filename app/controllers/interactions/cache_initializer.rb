module CacheInitializer
	extend self

	# Also priv_contact_id and org_contact_id

	def generate_values
		Rails.cache.write('priv_name', (0...8).map { (65 + rand(26)).chr }.join) unless Rails.cache.exist?('priv_name')
    Rails.cache.write('org_name', (0...8).map { (65 + rand(26)).chr }.join) unless Rails.cache.exist?('org_name')
  
    set_transfer_domain_data unless Rails.cache.exist?('transfer_code')

		domain_one = (0...8).map { (65 + rand(26)).chr }.join
		Rails.cache.write('domain_one', domain_one.to_s + ".ee") unless Rails.cache.exist?('domain_one')

		domain_two = (0...8).map { (65 + rand(20)).chr }.join
		Rails.cache.write('domain_two', domain_two.to_s + ".ee") unless Rails.cache.exist?('domain_two')

		random_nameserver = (0...8).map { (65 + rand(26)).chr }.join
		Rails.cache.write('random_nameserver', "ns1." + random_nameserver.to_s + ".ee") unless Rails.cache.exist?('random_nameserver')

		random_nameserver_one = (0...8).map { (65 + rand(26)).chr }.join
		Rails.cache.write('random_nameserver_one', "ns1." + random_nameserver_one.to_s + ".ee") unless Rails.cache.exist?('random_nameserver_one')

		random_nameserver_two = (0...8).map { (65 + rand(26)).chr }.join
		Rails.cache.write('random_nameserver_two', "ns1." + random_nameserver_two.to_s + ".ee") unless Rails.cache.exist?('random_nameserver_two')
	end

  private

  def set_transfer_domain_data
    result = GenerateTransferCode.process

    transfer_code = result["data"]["domain"]["transfer_code"]
    transfer_domain_name = result["data"]["domain"]["name"]

    Rails.cache.write('transfer_code', transfer_code) unless Rails.cache.exist?('transfer_code')
    Rails.cache.write('transfer_domain_name', transfer_domain_name) unless Rails.cache.exist?('transfer_domain_name')
  end
end
