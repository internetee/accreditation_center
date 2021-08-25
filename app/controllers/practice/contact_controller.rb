class Practice
  class ContactController < ApplicationController
    before_action :set_api_connector
    before_action :set_cache

    ACTION = "contact".freeze

    def index
      @priv_name = Rails.cache.fetch('priv_name')
      @org_name = Rails.cache.fetch('org_name')

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
      Rails.cache.write('priv_name', (0...8).map { (65 + rand(26)).chr }.join) unless Rails.cache.exist?('priv_name')
      Rails.cache.write('org_name', (0...8).map { (65 + rand(26)).chr }.join) unless Rails.cache.exist?('org_name')
    end

    def set_api_connector
      token = session[:auth_token]
      @api_connector = GetContact.new(token)
    end
  end
end
