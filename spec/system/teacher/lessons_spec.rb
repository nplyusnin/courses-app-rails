# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Teacher/Lessons", type: :system do
  let(:teacher) { create(:user, :teacher) }
  let(:course) { create(:course, teacher: teacher) }

  before do
    sign_in(teacher)
  end

  describe "Teacher creates a new lesson" do
    before do
      visit new_teacher_course_lesson_path(course)
    end

    context "with valid parameters" do
      let(:valid_lesson_params) { attributes_for(:lesson) }

      it "successfully creates a lesson" do
        fill_in I18n.t("activerecord.attributes.lesson.title"), with: valid_lesson_params[:title]
        click_button I18n.t("resources.teacher.lessons.save_as_draft")

        expect(page).to have_content(I18n.t("notices.teacher.lessons.created"))
        expect(page).to have_content(valid_lesson_params[:title])
        expect(course.reload.lessons.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      it "fails to create a lesson with invalid data" do
        click_button I18n.t("resources.teacher.lessons.save_as_draft")

        expect(page).to have_content(I18n.t("errors.messages.blank"))
        expect(course.reload.lessons.count).to eq(0)
      end
    end
  end
end
