class ResultStatusPresenter
	include ActionView::Helpers::TagHelper

  attr_reader :quiz
	delegate_missing_to :@quiz

	def initialize(quiz:, user:)
		@quiz = quiz
    @user = user
	end

  def status
    if @quiz.theory
      return generate_tag(@quiz.result.result) if @quiz.result

      content_tag(:span, "Waiting for chellenge", class: "text-sm px-3 py-1 bg-indigo-200 text-indigo-800 rounded-full")

    else
      @in_proccess = Practice.find_by(user: user, action_name: 'domain')
      @practice = PracticeResult.find_by(user: user)
      return generate_tag(@practice.result) unless @practice.nil?

      return content_tag(:span, "In Proccess", class: "text-sm px-3 py-1 bg-red-200 text-red-800 rounded-full") unless @in_proccess.nil? 
      content_tag(:span, "Waiting for chellenge", class: "text-sm px-3 py-1 bg-indigo-200 text-indigo-800 rounded-full")
    end
  end


  def generate_tag(flag)
    return content_tag(:span, "Passed", class: "text-sm px-3 py-1 bg-green-200 text-green-800 rounded-full") if flag
	  content_tag(:span, "Failed", class: "text-sm px-3 py-1 bg-red-400 text-gray-800 rounded-full")
  end
end
