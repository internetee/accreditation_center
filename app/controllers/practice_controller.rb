class PracticeController < ApplicationController
  before_action :set_api_connector
  
  def index
  end

  def contact
    action = "contact"
    practice = Practice.find_by(user: current_user, action_name: action)
    contact_id = params[:contact_id]

    if practice.nil?
      @result = GenerateContactResult.process(contact_id: contact_id, api_connector: @api_connector, action: action, user:current_user)
    else
      @result = practice.result
    end
  end

  private

  def set_api_connector
    token = session[:auth_token]
    @api_connector = GetContact.new(token)
  end
end
