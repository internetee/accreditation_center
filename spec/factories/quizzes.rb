FactoryBot.define do
  factory :quiz do
    title { "MyString" }
    user { association(:user) }
  end
end
