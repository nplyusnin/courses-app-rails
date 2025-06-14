# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Student Lessons", type: :system do
  let!(:student) { create(:student) }
  let!(:course) { create(:course) }
  let!(:lessons) { create_list(:lesson, 3, course: course) }

  before do
    student.study_courses << course
    sign_in(student)
  end

  context "when complete lessons not exists" do
    it "displays only first lesson" do
      visit student_course_lessons_path(course)

      expect(page).to have_content(lessons.first.title)
      expect(page).not_to have_content(lessons.second.title)
      expect(page).not_to have_content(lessons.third.title)
    end
  end

  context "when first lesson is completed" do
    before do
      student.done_lessons << lessons.first
    end

    it "displays first and second lessons" do
      visit student_course_lessons_path(course)

      expect(page).to have_content(lessons.first.title)
      expect(page).to have_content(lessons.second.title)
      expect(page).not_to have_content(lessons.third.title)
    end
  end

  context "when all lessons are completed" do
    before do
      student.done_lessons << lessons
    end

    it "displays all lessons" do
      visit student_course_lessons_path(course)

      lessons.each { expect(page).to have_content(it.title) }
    end
  end
end
