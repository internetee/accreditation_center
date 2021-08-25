class Practice
  class NameserverController < ApplicationController
    before_action :set_cache_memory
    before_action :set_api_connector
    
    ACTION = "nameserver".freeze

    def index
      practice = Practice.find_by(user: current_user, action_name: ACTION)

      if practice.nil?
        @result = GenerateNameserverResult.checking_data complete_data
      else
        @result = practice.result
      end
    end

    def complete_data
      {
        domain_one: @domain_one.downcase,
        domain_two: @domain_two.downcase,
        random_nameserver_one: @random_nameserver_one.downcase,
        random_nameserver_two: @random_nameserver_two.downcase,
        api_connector: @api_connector, 
        action: ACTION, 
        user:current_user,
      }
    end

    def set_api_connector
      token = session[:auth_token]
      @api_connector = GetDomain.new(token)
    end

    def set_cache_memory
      @domain_one = Rails.cache.read('domain_one')
      @domain_two = Rails.cache.read('domain_two')

      random_nameserver_one = (0...8).map { (65 + rand(26)).chr }.join
      Rails.cache.write('random_nameserver_one', random_nameserver_one.to_s + ".ee") unless Rails.cache.exist?('random_nameserver_one')
      @random_nameserver_one = Rails.cache.read('random_nameserver_one')

      random_nameserver_two = (0...8).map { (65 + rand(26)).chr }.join
      Rails.cache.write('random_nameserver_two', random_nameserver_two.to_s + ".ee") unless Rails.cache.exist?('random_nameserver_two')
      @random_nameserver_two = Rails.cache.read('random_nameserver_two')

      @random_nameserver = Rails.cache.read('random_nameserver')

    end
  end
end