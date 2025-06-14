# frozen_string_literal: true

module Api
  module V1
    module Student
      class LessonDetailsSerializer
        private attr_reader :record

        def initialize(record)
          @record = record
        end

        def as_json
          {
            id: record.id,
            title: record.title,
            content: record.content&.body&.to_s
          }
        end
      end
    end
  end
end
