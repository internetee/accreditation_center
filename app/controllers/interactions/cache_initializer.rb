module CacheInitializer
  extend self

  # Also priv_contact_id and org_contact_id

  def generate_values
    Rails.cache.write('priv_name', (0...8).map { rand(97..122).chr }.join) unless Rails.cache.exist?('priv_name')
    Rails.cache.write('org_name', (0...8).map { rand(97..122).chr }.join) unless Rails.cache.exist?('org_name')

    set_transfer_domain_data unless Rails.cache.exist?('transfer_code')

    domain_one = (0...8).map { rand(97..122).chr }.join
    Rails.cache.write('domain_one', domain_one.to_s + '.ee') unless Rails.cache.exist?('domain_one')

    domain_two = (0...8).map { rand(97..116).chr }.join
    Rails.cache.write('domain_two', domain_two.to_s + '.ee') unless Rails.cache.exist?('domain_two')

    random_nameserver = (0...8).map { rand(97..122).chr }.join
    unless Rails.cache.exist?('random_nameserver')
      Rails.cache.write('random_nameserver',
                        'ns1.' + random_nameserver.to_s + '.ee')
    end

    random_nameserver_one = (0...8).map { rand(97..122).chr }.join
    unless Rails.cache.exist?('random_nameserver_one')
      Rails.cache.write('random_nameserver_one',
                        'ns1.' + random_nameserver_one.to_s + '.ee')
    end

    random_nameserver_two = (0...8).map { rand(97..122).chr }.join
    unless Rails.cache.exist?('random_nameserver_two')
      Rails.cache.write('random_nameserver_two',
                        'ns1.' + random_nameserver_two.to_s + '.ee')
    end
  end

  private

  def set_transfer_domain_data
    result = GenerateTransferCode.process

    Rails.logger.info 'No domain was generated. Got empty value from registry' if result.nil?
    Rails.logger.info result['message'] if result['code'] == 2104

    transfer_code = result['data']['domain']['transfer_code']
    transfer_domain_name = result['data']['domain']['name']

    Rails.cache.write('transfer_code', transfer_code) unless Rails.cache.exist?('transfer_code')
    Rails.cache.write('transfer_domain_name', transfer_domain_name) unless Rails.cache.exist?('transfer_domain_name')
  end
end
