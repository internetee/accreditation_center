require_relative '../services/api_connector.rb'


class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @quizzes = Quiz.where(user: current_user)
  end
end
