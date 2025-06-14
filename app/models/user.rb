# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  has_many :teaching_courses, class_name: "Course", foreign_key: "teacher_id", dependent: :destroy
  has_many :student_courses, class_name: "StudentCourse", foreign_key: "student_id", dependent: :destroy
  has_many :study_courses, through: :student_courses, class_name: "Course", foreign_key: "course_id", source: :course
  has_many :student_lessons, foreign_key: "student_id", dependent: :destroy
  has_many :done_lessons, class_name: "Lesson", through: :student_lessons, source: :lesson

  enum :role, { student: "student", teacher: "teacher", admin: "admin" }, validate: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
end
