# frozen_string_literal: true

require "rails_helper"

RSpec.describe StudentCourse, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:student).class_name("User").with_foreign_key("student_id") }
    it { is_expected.to belong_to(:course) }
  end
end
