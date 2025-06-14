# frozen_string_literal: true

module Api
  module V1
    module Student
      class LessonsController < Api::V1::BaseController
        before_action :set_course
        before_action :set_lessons
        before_action :set_lesson, only: %i[show done]

        def index
          render json: @lessons.map { Api::V1::Student::LessonPreviewSerializer.new(it) }
        end

        def show
          render json: Api::V1::Student::LessonDetailsSerializer.new(@lesson).as_json.merge(
            next_lesson_id: @lessons.find { |l| l.position > @lesson.position }&.id,
            previous_lesson_id: @lessons.find { |l| l.position < @lesson.position }&.id
          )
        end

        def done
          if current_user.done_lessons.include?(@lesson)
            render json: { message: "Вы уже прошли этот урок" }, status: :unprocessable_entity
          else
            current_user.done_lessons << @lesson
            render json: { message: "Урок успешно пройден" }, status: :ok
          end
        end

        private

        def set_course
          @course = Course.find(params[:course_id])
        end

        def set_lessons
          @lessons = ::Users::AvailableLessonsQuery.new(current_user, @course).resolve
        end

        def set_lesson
          @lesson = @lessons.find { it.id.to_s == params[:id] }
        end
      end
    end
  end
end
