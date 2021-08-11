class ResultsJob < ApplicationJob
  # queue_as :default

	def perform(user_id)
		@user = user_results(user_id)

		result_processor()
    p "==================="
    p "==================="
    p "==================="
    p "RESULT"
    p @res
    p "==================="
    p "==================="
    p "==================="

    @res
	end

	private

  def user_results(user_id)
		User.find(user_id)
	end

	def result_processor
		@user.quizzes.each do |quiz|
			process_quiz(quiz.id)
		end
	end

	def user_finish_all_tests?(categories)
    categories.each do |cat|
      return false unless cat.has_results?
    end

    true
	end

  def process_quiz(quiz_id)
		categories = @user.user_categories(quiz_id)
    result = user_finish_all_tests?(categories)

    @res = handler_results(categories) if result
    @res = "User didn't finish tests" unless result
	end

  def handler_results(categories)
    @result = true
    result_collection = @user.results.where(category_id: categories, result: true)

    result_collection.count == categories.count
  end
end
