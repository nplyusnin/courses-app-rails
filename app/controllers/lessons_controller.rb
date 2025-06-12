# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_course

  def index
    @lessons = @course.lessons
  end

  def show = @lesson = @course.lessons.find(params[:id])

  private

  def set_course = @course = Course.find(params[:course_id])
end
