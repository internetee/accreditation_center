FactoryBot.define do
  factory :result do
    id { "1" }
    user { association(:user) }
    quiz { association(:quiz) }
    user_answer { association(:user_answer) }
    result { false }
  end
end
