# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index = @courses = Course.all

  def show = @course = Course.find(params[:id])

  def enroll
    @course = Course.find(params[:id])

    if current_user.study_courses.include?(@course)
      redirect_to @course, alert: I18n.t("notices.my_courses.already_enrolled")
    else
      current_user.study_courses << @course
      redirect_to @course, notice: I18n.t("notices.my_courses.enrolled")
    end
  end
end
