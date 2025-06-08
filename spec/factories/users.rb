FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.org" }
    password { "password" }
    password_confirmation { "password" }
  end
end
