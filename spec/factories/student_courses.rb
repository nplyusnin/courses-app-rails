# frozen_string_literal: true

FactoryBot.define do
  factory :student_course do
    association(:student)
    association(:course)
  end
end
