require_relative '../services/api_connector.rb'


class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @quizzes = Quiz.all

    # test_request = ApiConnector.new(username: "oleghasjanov", password: "123456")
    # @result = test_request.get_pull_message(method: :get)
  end
end
