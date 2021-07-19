FactoryBot.define do
  factory :category do
    title { "MyString" }
    quiz { association(:quiz) }
  end
end
