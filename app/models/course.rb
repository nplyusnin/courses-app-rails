# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User", foreign_key: "teacher_id"
  has_many :lessons, dependent: :destroy
  has_many :student_courses, dependent: :destroy
  has_many :students, through: :student_courses, class_name: "User", foreign_key: "student_id"

  has_one_attached :preview_image
  has_rich_text :description

  validates :title, presence: true
end
