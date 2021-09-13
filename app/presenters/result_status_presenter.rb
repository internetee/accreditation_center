class ResultStatusPresenter
	include ActionView::Helpers::TagHelper

	delegate_missing_to :@quiz

	def initialize(quiz:, user:)
		@quiz = quiz
    @user = user
	end

  def status
    if @quiz.theory
      return generate_tag(@quiz.result.result) if @quiz.result

      content_tag(:span, "Waiting for chellenge")

    else
      @in_proccess = Practice.find_by(user: user, action_name: 'domain')
      @practice = PracticeResult.find_by(user: user)
      return generate_tag(@practice.result) unless @practice.nil?

      return content_tag(:span, "In Proccess", class: "answered") unless @in_proccess.nil? 
      content_tag(:span, "Waiting for chellenge")
    end
  end


  def generate_tag(flag)
    return content_tag(:span, "True", class: "green") if flag
	  content_tag(:span, "Fails", class: "answered")
  end
end
