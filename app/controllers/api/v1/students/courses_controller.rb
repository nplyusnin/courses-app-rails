# frozen_string_literal: true

module Api
  module V1
    module Students
      class CoursesController < BaseController
        def index
          courses_serialized = current_user.study_courses.map { CoursePreviewSerializer.new(it) }
          render json: courses_serialized, status: 200
        end

        def show
          course_serialized = CourseDetailsSerializer.new(current_user.study_courses.find(params[:id]))
          render json: course_serialized, status: 200
        end
      end
    end
  end
end
