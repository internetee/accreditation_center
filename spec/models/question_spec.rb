require 'rails_helper'

RSpec.describe Question, type: :model do
  include Rack::Test::Methods
  context 'check validation' do
    let(:question) { build(:question, title: "Hey") }

    it 'check presence of title field' do
      question.title = nil

      expect(question.save).to be false
    end
  end
end
