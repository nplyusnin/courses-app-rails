# frozen_string_literal: true

require "rails_helper"

RSpec.describe Lesson, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:course) }
  end

  describe "rich text" do
    it { is_expected.to have_rich_text(:content) }
  end

  describe "validations" do
    subject { build(:lesson) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:course_id) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(0) }
  end
end
