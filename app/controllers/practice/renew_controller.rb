class Practice
  class RenewController < ApplicationController
    before_action :check_access
    before_action :set_api_connector
    before_action :set_cache_memory
    before_action :set_practice

    ACTION = "renew".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateRenewResult.checking_data complete_data
      redirect_to practice_renew_index_path
    end

    private

    def check_access
      transfer = Practice.find_by(action_name: "transfer", user: current_user, result: true)
      return unless transfer.nil?

      redirect_to practice_transfer_index_path, notice: "You need first finish this task"
    end

    def complete_data
      {
        domain_one: @domain_one.downcase,
        domain_two: @domain_two.downcase,
        domain_one_expire_date: @domain_one_expire_date,
        domain_two_expire_date: @domain_two_expire_date,
        api_connector: @api_connector, 
        action: ACTION, 
        user:current_user,
      }
    end

    def set_practice
      @practice = Practice.find_by(user: current_user, action_name: ACTION)
    end

    def set_api_connector
      token = session[:auth_token]
      @api_connector = GetDomain.new(token)
    end

    def set_cache_memory
      @domain_one = Rails.cache.read('domain_one')
      @domain_two = Rails.cache.read('domain_two')

      get_domains_expire_dates

      @domain_one_expire_date = Rails.cache.read("domain_#{@domain_one}_expire_date")
      @domain_two_expire_date = Rails.cache.read("domain_#{@domain_two}_expire_date")
    end

    def get_domains_expire_dates
      GetDomainExpireDate.process(domain: @domain_one, api_connector: @api_connector)
      GetDomainExpireDate.process(domain: @domain_two, api_connector: @api_connector)
    end
  end
end
