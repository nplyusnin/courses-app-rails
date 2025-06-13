# frozen_string_literal: true

module Api
  module V1
    class CoursesController < BaseController
      def index
        render json: Course.all, status: :ok
      end

      def show
        render json: Course.find(params[:id]), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {}, status: :not_found
      end
    end
  end
end
