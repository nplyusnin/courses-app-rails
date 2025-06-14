# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Teacher/Lessons", type: :system do
  let(:teacher) { create(:user, :teacher) }
  let(:course) { create(:course, teacher: teacher) }

  before do
    sign_in(teacher)
  end

  describe "Teacher visits lessons list page" do
    let!(:lessons) { create_list(:lesson, 2, course: course) }

    before do
      visit teacher_course_lessons_path(course)
    end

    it "displays the lessons list" do
      lessons.each do |lesson|
        expect(page).to have_content(lesson.title)
      end
    end
  end

  describe "Teacher visit a lesson page" do
    let(:lesson) { create(:lesson, course: course) }

    before do
      visit teacher_lesson_path(lesson)
    end

    it "displays the lesson details" do
      expect(page).to have_content(lesson.title)
      expect(page).to have_content(lesson.content)
    end
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

  describe "Teacher edits a lesson" do
    let!(:lesson) { create(:lesson, course: course) }

    before do
      visit edit_teacher_lesson_path(lesson)
    end

    context "with valid parameters" do
      let(:updated_lesson_params) { attributes_for(:lesson, title: "Updated Lesson Title") }

      it "update lesson and render updated lesson" do
        fill_in I18n.t("activerecord.attributes.lesson.title"), with: updated_lesson_params[:title]
        click_button I18n.t("resources.teacher.lessons.save_as_draft")

        expect(page).to have_content(I18n.t("notices.teacher.lessons.updated"))
        expect(page).to have_content(updated_lesson_params[:title])
        expect(lesson.reload.title).to eq(updated_lesson_params[:title])
      end
    end

    context "with invalid parameters" do
      it "not update lesson and render errors" do
        fill_in I18n.t("activerecord.attributes.lesson.title"), with: ""
        click_button I18n.t("resources.teacher.lessons.save_as_draft")

        expect(page).to have_content(I18n.t("errors.messages.blank"))
        expect(lesson.reload.title).not_to eq("")
      end
    end
  end

  describe "Teache deletes a lesson" do
    let!(:lesson) { create(:lesson, course: course) }

    before do
      visit edit_teacher_lesson_path(lesson)
    end

    it "successfully deletes a lesson" do
      click_link I18n.t("resources.teacher.lessons.destroy")

      expect(page).to have_content(I18n.t("notices.teacher.lessons.destroyed"))
      expect(page).not_to have_content(lesson.title)
      expect(course.reload.lessons.count).to eq(0)
    end
  end
end
