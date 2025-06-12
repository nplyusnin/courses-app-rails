# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Lessons", type: :system do
  let(:course)   { create(:course) }
  let!(:lessons) { create_list(:lesson, 2, course: course) }
  let(:lesson)   { lessons.first }
  let(:student)  { create(:student) }

  before do
    student.study_courses << course
    sign_in student
  end

  it "allows a student to view a first available lesson" do
    visit course_lessons_path(course)

    expect(page).to have_content(lessons.first.title)
  end

  it "allows a student to view a lesson details" do
    visit course_lesson_path(course, lesson)

    expect(page).to have_content(lesson.title)
    expect(page).to have_content(lesson.content.to_plain_text)
  end

  it "allows a student mark a lesson as done" do
    visit course_lesson_path(course, lesson)

    click_link "Отметить как пройденный"

    expect(page).to have_content("Вы успешно прошли урок")

    expect(student.reload.done_lessons).to include(lesson)
  end
end
