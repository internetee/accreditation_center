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
