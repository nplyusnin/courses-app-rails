require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:teacher).class_name('User').with_foreign_key('teacher_id') }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
  end
end
