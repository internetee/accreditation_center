FactoryBot.define do
  factory :user_question do
    category { association(:category) }
    question { association(:question) }
    quiz { association(:quiz) }
    user { association(:user) }
  end
end
