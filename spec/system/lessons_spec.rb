# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Lessons", type: :system do
  let(:course) { create(:course) }
  let!(:lessons) { create_list(:lesson, 2, course: course) }
  let(:student) { create(:student) }

  before do
    student.study_courses << course
    sign_in student
  end

  it "allows a student to view a lessons" do
    visit course_lessons_path(course)

    lessons.each do |lesson|
      expect(page).to have_content(lesson.title)
    end
  end
end
