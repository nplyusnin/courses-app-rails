FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.org" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :student, parent: :user do
    role { :student }
  end

  factory :teacher, parent: :user do
    role { :teacher }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
