# frozen_string_literal: true

require "rails_helper"

RSpec.describe "My Courses", type: :system do
  let(:student) { create(:student) }
  let!(:student_course) { create_list(:student_course, 2, student: student) }
  let!(:other_student_course) { create_list(:student_course, 2) }

  before do
    sign_in(student)
    visit root_path
  end

  it "displays the student's courses" do
    student_course.each do |course|
      expect(page).to have_content(course.course.title)
    end

    other_student_course.each do |course|
      expect(page).not_to have_content(course.course.title)
    end
  end
end
