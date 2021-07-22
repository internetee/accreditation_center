require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  describe "abilities" do
    user = User.create(email: "test@test.test", password: "123456", superadmin_role: true)
    ability = Ability.new(user)
    it { expect(ability).to be_able_to(:create, Question.new) }
    it { expect(ability).to be_able_to(:destroy, Question.new) }
  end
end
