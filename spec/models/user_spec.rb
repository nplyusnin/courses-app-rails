# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "enums" do
    it do
      is_expected.to define_enum_for(:role)
        .with_values(
          student: "student",
          teacher: "teacher",
          admin: "admin"
        )
        .backed_by_column_of_type(:string)
        .validating
    end
  end

  describe "associations" do
    it do
      is_expected.to have_many(:teaching_courses)
        .class_name("Course")
        .with_foreign_key("teacher_id")
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:student_courses)
        .class_name("StudentCourse")
        .with_foreign_key("student_id")
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:study_courses)
        .through(:student_courses)
        .class_name("Course")
        .with_foreign_key("course_id")
        .source(:course)
    end

    it do
      is_expected.to have_many(:student_lessons)
        .with_foreign_key("student_id")
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:done_lessons)
        .class_name("Lesson")
        .through(:student_lessons)
        .source(:lesson)
    end
  end
end
