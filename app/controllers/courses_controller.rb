# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index = @courses = Course.all

  def show = @course = Course.find(params[:id])
end
