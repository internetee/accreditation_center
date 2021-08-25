class Practice
  class ContactController < ApplicationController
    before_action :set_api_connector
    before_action :set_cache

    ACTION = "contact".freeze

    def index
      practice = Practice.find_by(user: current_user, action_name: ACTION)

      if practice.nil?
        @result = GenerateContactResult.checking_data complete_data
      else
        @result = practice.result
      end
    end

    private

    def complete_data
      {
        priv_contact_id: params[:priv_contact_id],
        org_contact_id: params[:org_contact_id],
        api_connector: @api_connector, 
        action: ACTION, 
        user:current_user,
        priv_name: @priv_name,
        org_name: @org_name
      }
    end

    def set_cache
      @priv_name = Rails.cache.read('priv_name')
      @org_name = Rails.cache.read('org_name')
    end

    def set_api_connector
      token = session[:auth_token]
      @api_connector = GetContact.new(token)
    end
  end
end
