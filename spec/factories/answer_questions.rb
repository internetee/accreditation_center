FactoryBot.define do
  factory :answer_question do
    question_id { association(:question) }
    answer_id { association(:answer) }
    user_answer { association(:user_answer) }
    quiz { association(:quiz) }
  end
end
