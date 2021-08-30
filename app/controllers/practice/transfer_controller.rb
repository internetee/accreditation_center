class Practice
  class TransferController < ApplicationController
    before_action :set_cache_memory
    before_action :set_api_connector
    before_action :set_practice

    ACTION = "transfer".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateTransferCodeResult.checking_data complete_data
      redirect_to practice_transfer_index_path
    end

    private

    def complete_data
      {
        domain_name: @transfer_domain_name.downcase,
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
      @transfer_code = Rails.cache.read('transfer_code')
      @transfer_domain_name = Rails.cache.read('transfer_domain_name')
    end
  end
end
