# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Teacher/Courses", type: :system do
  let(:teacher) { create(:user, :teacher) }
  let!(:courses) { create_list(:course, 2, teacher: teacher) }
  let(:course) { courses.first }

  before do
    sign_in(teacher)
  end

  describe "Teacher visit courses list page" do
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

  describe "Teacher view course details" do
    it "displays the course details" do
      visit teacher_course_path(course)

      expect(page).to have_content(course.title)
    end
  end

  describe "Teacher creates a new course" do
    before do
      visit new_teacher_course_path
    end

    context "when the teacher tries create a course with valid parameters" do
      let(:valid_course_params) { attributes_for(:course) }

      it "create the course and redirect to course details" do
        fill_in I18n.t("activerecord.attributes.course.title"), with: valid_course_params[:title]
        click_button I18n.t("resources.teacher.courses.save_as_draft")

        expect(page).to have_content(I18n.t("notices.teacher.courses.created"))
        expect(page).to have_content(valid_course_params[:title])
        expect(page).to have_current_path(teacher_course_path(Course.last))
      end
    end

    context "when the teacher tries create a course with invalid parameters" do
      it "shows error messages and does not create the course" do
        fill_in I18n.t("activerecord.attributes.course.title"), with: ""
        click_button I18n.t("resources.teacher.courses.save_as_draft")

        expect(page).to have_content("не может быть пустым")
      end
    end
  end

  describe "Teacher updates course" do
    before do
      visit edit_teacher_course_path(course)
    end

    context "when the teacher tries update course details with valid parameters" do
      let(:valid_course_params) { attributes_for(:course) }

      it "updates the course and redirect to course details" do
        fill_in I18n.t("activerecord.attributes.course.title"), with: valid_course_params[:title]
        click_button I18n.t("resources.teacher.courses.save_as_draft")

        expect(page).to have_content(I18n.t("notices.teacher.courses.updated"))
        expect(page).to have_content(valid_course_params[:title])
        expect(page).to have_current_path(teacher_course_path(course))
      end
    end

    context "when the teacher tries to update course with invalid parameters" do
      it "shows error messages and does not update the course" do
        fill_in I18n.t("activerecord.attributes.course.title"), with: ""
        click_button I18n.t("resources.teacher.courses.save_as_draft")

        expect(page).to have_content("не может быть пустым")
      end
    end
  end

  describe "Teacher deletes course" do
    before do
      visit edit_teacher_course_path(course)
    end

    it "deletes the user and redirects to the users index page" do
      click_link I18n.t("resources.teacher.courses.destroy")

      expect(page).to have_current_path(teacher_courses_path)
      expect(page).to have_content(I18n.t("notices.teacher.courses.destroyed"))
      expect(Course.exists?(course.id)).to be_falsey
    end
  end
end
