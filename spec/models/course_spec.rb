# frozen_string_literal: true

require "rails_helper"

RSpec.describe Course, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:teacher).class_name("User").with_foreign_key("teacher_id") }
    it { is_expected.to have_many(:lessons).order(:position).dependent(:destroy) }
    it { is_expected.to have_many(:student_courses).dependent(:destroy) }
    it {
      is_expected.to have_many(:students)
        .through(:student_courses)
        .class_name("User")
        .with_foreign_key("student_id")
    }
  end

  describe "attachments" do
    it { is_expected.to have_one_attached(:preview_image) }
  end

  describe "rich text" do
    it { is_expected.to have_rich_text(:description) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
  end
end
