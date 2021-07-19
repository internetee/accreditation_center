class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @quizzes = Quiz.all
  end
end
