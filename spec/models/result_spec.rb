require 'rails_helper'

RSpec.describe Result, type: :model do
  let(:result) { build(:result) }

  context 'archived' do
    it 'result should be archived if life continues more that 30 days' do
      result.created_at = Time.now - 30.days
      result.save

      expect(result.created_at < Time.now).to be true
      expect(result.archived?).to be true
    end

    it 'result should not be arhived if life continues less that 30 days' do
      result.save

      expect(result.created_at < Time.now + 30.days).to be true
      expect(result.archived?).to be false
    end
  end
end
