# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Courses List", type: :system do
  let(:student) { create(:student) }
  let!(:courses) { create_list(:course, 2) }
  let(:course) { courses.first }

  before do
    sign_in student
    visit courses_path
  end

  it "displays the list of courses" do
    courses.each do |course|
      expect(page).to have_content(course.title)
    end
  end

  it "allows the student to view a course" do
    visit course_path(course)

    expect(page).to have_content(course.title)
  end
end
