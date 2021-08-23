class Practice
  class ContactController < ApplicationController
    before_action :set_api_connector
    before_action :set_sessions

    ACTION = "contact".freeze

    def index
      @priv_name = session[:priv_name]
      @org_name = session[:org_name]

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

    def set_sessions
      session[:priv_name] = (0...8).map { (65 + rand(26)).chr }.join if session[:priv_name].nil?
      session[:org_name] = (0...8).map { (65 + rand(26)).chr }.join if session[:org_name].nil?
    end

    def set_api_connector
      token = session[:auth_token]
      @api_connector = GetContact.new(token)
    end
  end
end
