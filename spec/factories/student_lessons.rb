# frozen_string_literal: true

FactoryBot.define do
  factory :student_lesson do
    association(:student)
    association(:lesson)
  end
end
