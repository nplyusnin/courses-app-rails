# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Teacher view course details", type: :system do
  let(:teacher) { create(:user, :teacher) }
  let!(:course) { create(:course, teacher: teacher) }

  before do
    sign_in(teacher)
  end

  it "displays the course details" do
    visit teacher_course_path(course)

    expect(page).to have_content(course.title)
  end
end
