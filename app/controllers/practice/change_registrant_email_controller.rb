class Practice
  class ChangeRegistrantEmailController < ApplicationController
    before_action :set_cache_memory
    before_action :set_api_connector
    before_action :set_practice

    ACTION = "change_registrant_email".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateChangeRegistrantEmailResult.checking_data complete_data
      redirect_to practice_change_registrant_email_index_path
    end

    private

    def complete_data
      {
        domain_name: @domain_one.downcase,
        api_connector: @api_connector, 
        action: ACTION, 
        user:current_user,
        verified: false,
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
      @priv_name = Rails.cache.read('priv_name')
      @org_name = Rails.cache.read('org_name')
      @domain_one = Rails.cache.read('domain_one')
    end
  end
end
