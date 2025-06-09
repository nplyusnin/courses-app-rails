require "rails_helper"

RSpec.describe "Teach view list of courses", type: :system do
  let(:teacher) { create(:user, :teacher) }
  let!(:courses) { create_list(:course, 2, teacher: teacher) }

  before do
    sign_in(teacher)
  end

  it "displays the list of courses" do
    visit teacher_courses_path

    courses.each do |course|
      expect(page).to have_content(course.title)
    end
  end

  it "does not show courses from other teachers" do
    other_course = create(:course)

    visit teacher_courses_path

    expect(page).not_to have_content(other_course.title)
  end
end