FactoryBot.define do
  factory :result do
    id { "1" }
    user { association(:user) }
    category { association(:category) }
    user_answer { association(:user_answer) }
    result { false }
  end
end
