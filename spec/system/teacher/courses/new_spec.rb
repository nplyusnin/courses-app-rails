# frozen_string_literal: true

require "rails_helper"

describe "Teacher create a new course", type: :system do
  let(:teacher) { create(:teacher) }

  before do
    sign_in(teacher)
  end

  context "when the teacher tries create a course with valid parameters" do
    it "create the course and redirect to course details" do
      visit new_teacher_course_path

      fill_in I18n.t("activerecord.attributes.course.title"), with: "Updated Course Title"
      click_button I18n.t("resources.teacher.courses.save_as_draft")

      expect(page).to have_content(I18n.t("notices.teacher.courses.created"))
      expect(page).to have_content("Updated Course Title")
      expect(page).to have_current_path(teacher_course_path(Course.last))
    end
  end

  context "when the teacher tries create a course with invalid parameters" do
    it "shows error messages and does not create the course" do
      visit new_teacher_course_path

      fill_in I18n.t("activerecord.attributes.course.title"), with: ""
      click_button I18n.t("resources.teacher.courses.save_as_draft")

      expect(page).to have_content("не может быть пустым")
    end
  end
end
