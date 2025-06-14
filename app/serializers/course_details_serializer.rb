class CourseDetailsSerializer
  include Rails.application.routes.url_helpers

  private attr_reader :record

  def initialize(record)
    @record = record
  end

  def as_json
    {
      id: record.id,
      title: record.title,
      image_preview: preview_image_url,
      description: record.description&.body&.to_s
    }
  end

  private

  def preview_image_url
    return unless record.preview_image.attached?

    rails_blob_path(record.preview_image, only_path: true)
  end
end
