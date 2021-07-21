require "rails_helper"

RSpec.describe QuestionsController, type: :routing do
  let(:quiz) { build(:quiz, id: 1) }

  describe "routing" do
    it "routes to #show" do
      expect(get: "quiz/#{quiz.id}/questions/1").to route_to("questions#show", id: "1", quiz_id: "1")
    end
  end
end
