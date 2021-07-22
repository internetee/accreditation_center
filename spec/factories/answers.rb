FactoryBot.define do
  factory :answer do
    title_en { "MyString" }
    title_ee { "MyString" }
    correct { false }
    question { association(:question) }
    user_answer { association(:user_answer) }
  end
end
