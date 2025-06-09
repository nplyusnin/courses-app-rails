# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :course

  has_rich_text :content

  validates :title, presence: true, uniqueness: { scope: :course_id }
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
