FactoryBot.define do
  factory :question do
    title { "How are doing?" }
    category { association(:category) }
  end
end
