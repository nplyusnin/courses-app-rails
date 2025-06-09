module Teacher
  class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course, only: [:show, :edit, :update, :destroy]

    def index
      @courses = current_user.teaching_courses.order(created_at: :desc)
    end

    def show;end

    def new
      @course = current_user.teaching_courses.build
    end

    def create
      @course = current_user.teaching_courses.build(course_params)

      if @course.save
        redirect_to teacher_course_path(@course), notice: I18n.t('notices.teacher.courses.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit;end

    def update
      if @course.update(course_params)
        redirect_to teacher_course_path(@course), notice: I18n.t('notices.teacher.courses.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @course.destroy
      redirect_to teacher_courses_path, notice: I18n.t('notices.teacher.courses.destroyed')
    end

    private

    def set_course() = @course = current_user.teaching_courses.find(params[:id])

    def course_params
      params.expect(course: [:title, :description, :preview_image])
    end
  end
end