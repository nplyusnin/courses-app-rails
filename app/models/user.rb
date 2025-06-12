# frozen_string_literal: true

class User < ApplicationRecord
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

  def available_lessons(course)
    course_done_lessons = done_lessons.where(course:)

    if course_done_lessons.size == course.lessons.size
      course.lessons.order(:position).to_a
    elsif course_done_lessons.empty?
      course.lessons.order(:position).first(1).to_a
    else
      course_done_lessons.where(course:) + [next_available_lesson(course)]
    end
  end

  def next_available_lesson(course)
    course.lessons.order(:position).find do |lesson|
      done_lessons.exclude?(lesson)
    end
  end
end
