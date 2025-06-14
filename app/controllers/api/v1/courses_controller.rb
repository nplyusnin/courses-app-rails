# frozen_string_literal: true

module Api
  module V1
    class CoursesController < BaseController
      def index
        courses_serialized = Course.all.map { CoursePreviewSerializer.new(it).as_json }
        render json: courses_serialized, status: :ok
      end

      def show
        render json: Course.find(params[:id]), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {}, status: :not_found
      end
    end
  end
end
