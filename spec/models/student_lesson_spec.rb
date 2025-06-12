# frozen_string_literal: true

require "rails_helper"

RSpec.describe StudentLesson, type: :model do
  describe "associations" do
    it do
      is_expected.to belong_to(:student)
        .class_name("User")
        .with_foreign_key("student_id")
        .inverse_of(:student_lessons)
    end

    it { is_expected.to belong_to(:lesson) }
  end
end
