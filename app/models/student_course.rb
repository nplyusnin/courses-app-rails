# frozen_string_literal: true

class StudentCourse < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :course
end
