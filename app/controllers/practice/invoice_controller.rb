class Practice
  class InvoiceController < ApplicationController
    before_action :set_api_connector
    before_action :set_practice

    ACTION = "invoice".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateInvoiceResult.checking_data complete_data
      redirect_to practice_invoice_index_path
    end

    private

    def complete_data
      {
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
      @api_connector = GetInvoice.new(token)
    end
  end
end
