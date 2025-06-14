# frozen_string_literal: true

module Api
  module V1
    class CoursePreviewSerializer
      include Rails.application.routes.url_helpers

      private attr_reader :record

      def initialize(record)
        @record = record
      end

      def as_json
        {
          id: record.id,
          title: record.title,
          preview_image: preview_image_url
        }
      end

      private

      def preview_image_url
        return unless record.preview_image.attached?

        rails_blob_path(record.preview_image, only_path: true)
      end
    end
  end
end
