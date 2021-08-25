class Practice
  class DomainsController < ApplicationController
    before_action :set_api_connector
    before_action :set_cache_memory

    ACTION = "domain".freeze

    def index
      practice = Practice.find_by(user: current_user, action_name: ACTION)

      if practice.nil?
        @result = GenerateDomainResult.checking_data complete_data
      else
        @result = practice.result
      end
    end

    private

    def complete_data
      {
        domain_one: @domain_one.downcase,
        domain_two: @domain_two.downcase,
        random_nameserver: @random_nameserver.downcase,
        api_connector: @api_connector, 
        action: ACTION, 
        user:current_user,
      }
    end

    def set_cache_memory
      domain_one = (0...8).map { (65 + rand(26)).chr }.join
      Rails.cache.write('domain_one', domain_one.to_s + ".ee") unless Rails.cache.exist?('domain_one')

      domain_two = (0...8).map { (65 + rand(20)).chr }.join
      Rails.cache.write('domain_two', domain_two.to_s + ".ee") unless Rails.cache.exist?('domain_two')

      random_nameserver = (0...8).map { (65 + rand(26)).chr }.join
      Rails.cache.write('random_nameserver', random_nameserver.to_s + ".ee") unless Rails.cache.exist?('random_nameserver')

      @domain_one = Rails.cache.read('domain_one')
      @domain_two = Rails.cache.read('domain_two')
      @random_nameserver = Rails.cache.read('random_nameserver')
    end

    def set_api_connector
      token = session[:auth_token]
      @api_connector = GetDomain.new(token)
    end
  end
end
