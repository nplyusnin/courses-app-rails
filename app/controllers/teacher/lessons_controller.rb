# frozen_string_literal: true

module Teacher
  class LessonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lesson, only: %i[show edit update destroy]
    before_action :set_course, only: %i[index new create]
    before_action :load_course, only: %i[show edit update destroy]

    def index = @lessons = @course.lessons.order(:position)

    def show; end

    def new = @lesson = @course.lessons.new

    def create
      @lesson = @course.lessons.new(lesson_params)
      @lesson.position = @course.lessons.maximum(:position).to_i + 1

      if @lesson.save
        redirect_to teacher_lesson_path(@lesson), notice: t("notices.teacher.lessons.created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @lesson.update(lesson_params)
        redirect_to teacher_lesson_path(@lesson), notice: t("notices.teacher.lessons.updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @lesson.destroy
      redirect_to teacher_course_lessons_path(@course), notice: t("notices.teacher.lessons.destroyed")
    end

    private

    def set_lesson = @lesson = Lesson.find(params[:id])

    def set_course = @course = current_user.teaching_courses.find(params[:course_id])

    def load_course = @course = @lesson.course

    def lesson_params = params.expect(lesson: %i[title position content])
  end
end
