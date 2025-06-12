# frozen_string_literal: true

class StudentLesson < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id", inverse_of: :student_lessons
  belongs_to :lesson
end
