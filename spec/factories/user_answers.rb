FactoryBot.define do
  factory :user_answer do
    user { association(:user) }
  end
end
