FactoryBot.define do
  factory :lesson do
    association(:course)
    sequence(:title) { |i| "Lesson #{i} -  title" }
    sequence(:position) { |i| i }
  end
end
