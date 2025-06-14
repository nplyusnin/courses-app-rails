# frozen_string_literal: true

module Api
  module V1
    module Student
      class LessonPreviewSerializer
        private attr_reader :record

        def initialize(record)
          @record = record
        end

        def as_json
          {
            id: record.id,
            title: record.title
          }
        end
      end
    end
  end
end
