require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build(:answer, correct: true) }
  it { expect(answer.correct_answer?).to be true }
end
