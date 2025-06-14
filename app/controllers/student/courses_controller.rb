# frozen_string_literal: true

module Student
  class CoursesController < ApplicationController
    before_action :authenticate_user!

    def index
      @courses = current_user.study_courses
    end
  end
end
