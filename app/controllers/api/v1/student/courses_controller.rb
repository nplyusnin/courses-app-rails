# frozen_string_literal: true

module Api
  module V1
    module Student
      class CoursesController < BaseController
        def index
          courses_serialized = current_user.study_courses.map { Api::V1::CoursePreviewSerializer.new(it) }
          render json: courses_serialized, status: 200
        end
      end
    end
  end
end
