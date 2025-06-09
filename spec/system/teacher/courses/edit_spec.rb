# frozen_string_literal: true

require "rails_helper"

describe "Teacher edit course", type: :system do
  let(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }

  before do
    sign_in(teacher)
  end

  context "when the teacher tries update course details with valid parameters" do
    it "updates the course and redirect to course details" do
      visit edit_teacher_course_path(course)

      fill_in I18n.t("activerecord.attributes.course.title"), with: "Updated Course Title"
      click_button I18n.t("resources.teacher.courses.save_as_draft")

      expect(page).to have_content(I18n.t("notices.teacher.courses.updated"))
      expect(page).to have_content("Updated Course Title")
      expect(page).to have_current_path(teacher_course_path(course))
    end
  end

  context "when the teacher tries to update course with invalid parameters" do
    it "shows error messages and does not update the course" do
      visit edit_teacher_course_path(course)

      fill_in I18n.t("activerecord.attributes.course.title"), with: ""
      click_button I18n.t("resources.teacher.courses.save_as_draft")

      expect(page).to have_content("не может быть пустым")
    end
  end
end
