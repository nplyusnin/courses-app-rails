# frozen_string_literal: true

module Users
  class AvailableLessonsQuery
    private attr_reader :user, :course, :lessons, :complete_lessons

    def initialize(user, course)
      @user = user
      @course = course
      @lessons = course.lessons.order(:position)
      @complete_lessons = user.done_lessons.where(course:)
    end

    def resolve
      return lessons.to_a if complete_lessons.size == lessons.size
      return lessons.first(1).to_a if complete_lessons.empty?

      complete_lessons + [next_available_lesson]
    end

    def next_available_lesson
      max_position = complete_lessons.maximum(:position)
      lessons.to_a.find { it.position > max_position }
    end
  end
end
