class Practice
  class ChangeRegistrantVerificationController < ApplicationController
    before_action :check_access
    before_action :set_cache_memory
    before_action :set_api_connector
    before_action :set_practice

    ACTION = "change_registrant_verification".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateChangeRegistrantEmailResult.checking_data complete_data
      redirect_to practice_change_registrant_verification_index_path
    end

    private

    def check_access
      change_registrant_email = Practice.find_by(action_name: "change_registrant_email", user: current_user, result: true)
      return unless change_registrant_email.nil?

      redirect_to practice_change_registrant_email_index_path, notice: "You need first finish this task"
    end

    def complete_data
      {
        domain_name: @domain_two.downcase,
        api_connector: @api_connector, 
        action: ACTION, 
        user:current_user,
        verified: true,
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
      @domain_two = Rails.cache.read('domain_two')
    end
  end
end
