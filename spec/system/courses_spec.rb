# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Courses List", type: :system do
  let(:student) { create(:student) }
  let!(:courses) { create_list(:course, 2) }
  let(:course) { courses.first }

  before do
    sign_in student
  end

  it "displays the list of courses" do
    visit courses_path

    courses.each do |course|
      expect(page).to have_content(course.title)
    end
  end

  it "allows the student to view a course" do
    visit course_path(course)

    expect(page).to have_content(course.title)
  end

  it "allows the student to enroll in a course" do
    visit course_path(course)

    click_link I18n.t("resources.courses.enroll")

    expect(page).to have_content(I18n.t("notices.my_courses.enrolled"))
    expect(page).to have_link(I18n.t("resources.my_courses.show"))
    expect(student.study_courses).to include(course)
  end
end
