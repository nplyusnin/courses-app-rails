FactoryBot.define do
  factory :course do
    sequence(:title) { |i| "Course #{i}" }
    association(:teacher)
  end
end
