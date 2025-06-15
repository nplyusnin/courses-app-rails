# frozen_string_literal: true

module Teacher
  class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course, only: %i[show edit update destroy]

    def index
      authorize [:teacher, Course]
      @courses = current_user.teaching_courses.order(created_at: :desc)
    end

    def show
      authorize [:teacher, @course]
    end

    def new
      authorize [:teacher, Course]
      @course = current_user.teaching_courses.build
    end

    def create
      authorize [:teacher, Course]
      @course = current_user.teaching_courses.build(course_params)

      if @course.save
        redirect_to teacher_course_path(@course), notice: I18n.t("notices.teacher.courses.created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize [:teacher, @course]
    end

    def update
      authorize [:teacher, @course]

      if @course.update(course_params)
        redirect_to teacher_course_path(@course), notice: I18n.t("notices.teacher.courses.updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:teacher, @course]
      @course.destroy
      redirect_to teacher_courses_path, notice: I18n.t("notices.teacher.courses.destroyed")
    end

    private

    def set_course = @course = current_user.teaching_courses.find(params[:id])

    def course_params
      params.expect(course: %i[title description preview_image])
    end
  end
end
