class Practice
  class DeleteController < ApplicationController
    before_action :set_cache_memory
    before_action :set_api_connector
    before_action :set_practice

    ACTION = "delete".freeze

    def index
      @result = @practice.result unless @practice.nil?
    end

    def create
      @result = GenerateDeleteResult.checking_data complete_data
      redirect_to practice_delete_index_path
    end

    private

    def complete_data
      {
        domain_name: @domain_one.downcase,
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
    end
  end
end
