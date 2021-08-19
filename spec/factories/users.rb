FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "test-#{n.to_s.rjust(3, "0")}" }
    sequence(:username) { |n| "test-#{n.to_s.rjust(3, "0")}" }
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.ee" }
    password { "123456" }
  end
end
