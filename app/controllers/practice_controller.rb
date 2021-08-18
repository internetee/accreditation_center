class PracticeController < ApplicationController
  def index
  end

  def contact
    
    @action = "contact"
    
    practice = Practice.find_by(user: current_user, action_name: @action)

    if practice.nil?
      @result = nil  
    else
      @result = practice.result
    end

    contact_id = params[:contact_id]
    token = session[:auth_token]

    api_connector = GetContact.new(token)


    unless contact_id.nil?
      response = api_connector.get_contact(contact_id)

      if response["code"] == 1000
        @result = true

        p = Practice.new
        p.user = current_user
        p.result = @result
        p.action_name = @action

        p.save!
      else
        @result = false
      end
    end

  end
end
