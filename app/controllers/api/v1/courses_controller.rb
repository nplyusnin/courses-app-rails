# frozen_string_literal: true

module Api
  module V1
    class CoursesController < BaseController
      def index
        courses_serialized = Course.all.map { CoursePreviewSerializer.new(it).as_json }
        render json: courses_serialized, status: :ok
      end

      def show
        course_serialized = CourseDetailsSerializer.new(Course.find(params[:id])).as_json
        render json: course_serialized, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {}, status: :not_found
      end
    end
  end
end
