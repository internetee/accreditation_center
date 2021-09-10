class Practice
  class DomainsController < ApplicationController
    before_action :check_access
    before_action :set_api_connector
    before_action :set_cache_memory
    before_action :set_practice

    ACTION = "domain".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateDomainResult.checking_data complete_data

      redirect_to practice_domains_path 
    end

    private

    def check_access
      contact = Practice.find_by(action_name: "contact", user: current_user, result: true)
      return unless contact.nil?

      redirect_to practice_contact_index_path, notice: "You need first finish this task"
    end

    def set_practice
      @practice = Practice.find_by(user: current_user, action_name: ACTION)
    end

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
