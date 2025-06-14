# frozen_string_literal: true

module Student
  class LessonsController < ApplicationController
    before_action :set_course
    before_action :set_lessons
    before_action :set_lesson, only: %i[show done]

    def index; end

    def show
      @previous_lesson = @lessons.filter do |lesson|
        lesson.position < @lesson.position
      end.last

      @next_lesson = @lessons.filter do |lesson|
        lesson.position > @lesson.position
      end.first
    end

    def done
      if current_user.done_lessons.include?(@lesson)
        redirect_to course_lesson_path(@course, @lesson), notice: "Вы уже прошли этот урок"
      else
        current_user.done_lessons << @lesson
        redirect_to course_lesson_path(@course, @lesson), notice: "Вы успешно прошли урок"
      end
    end

    private

    def set_course = @course = Course.find(params[:course_id])

    def set_lessons
      @lessons = Users::AvailableLessonsQuery.new(current_user, @course).resolve
    end

    def set_lesson
      @lesson = @lessons.find do |lesson|
        lesson.id == params[:id].to_i
      end
    end
  end
end
