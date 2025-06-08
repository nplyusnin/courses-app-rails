class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User", foreign_key: "teacher_id"

  has_one_attached :preview_image
  has_rich_text :description

  validates :title, presence: true
end
