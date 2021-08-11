require 'rails_helper'
require_relative "../support/devise"

RSpec.describe ResultsJob, :type => :job do
	let(:user) { build(:user) }
	let(:quiz) { build(:quiz) }
	let(:result) { build(:result, user: user, category: category) }
	let(:category) { build(:category, quiz: quiz) }

	  describe "Results Job should to send request to registy or return false" do
    it "should return false if user results are false" do
			quiz.save
			user.quizzes << quiz
			user.save
			category.save
			result.save
      ActiveJob::Base.queue_adapter = :test
      
			expect(ResultsJob.perform_now(user.id)).to be false
    end

		it "should return true if user results are true" do
			quiz.save
			user.quizzes << quiz
			user.save
			category.save
			result.result = true
			result.save
      ActiveJob::Base.queue_adapter = :test
      
			expect(ResultsJob.perform_now(user.id)).to be true
		end
  end
end