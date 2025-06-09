# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Teacher destroy course", type: :system do
  let(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher:) }

  before do
    sign_in teacher
    visit edit_teacher_course_path(course)
  end

  it "deletes the user and redirects to the users index page" do
    click_link I18n.t("resources.teacher.courses.destroy")

    expect(page).to have_current_path(teacher_courses_path)
    expect(page).to have_content(I18n.t("notices.teacher.courses.destroyed"))
    expect(Course.exists?(course.id)).to be_falsey
  end
end
