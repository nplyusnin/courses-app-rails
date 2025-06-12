# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: %i[show done]

  def index
    @lessons = current_user.available_lessons(@course)
  end

  def show
    @previous_lesson = current_user.available_lessons(@course).filter do |lesson|
      lesson.position < @lesson.position
    end.last

    @next_lesson = current_user.available_lessons(@course).filter do |lesson|
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

  def set_lesson
    @lesson = current_user.available_lessons(@course).find do |lesson|
      lesson.id == params[:id].to_i
    end
  end
end
