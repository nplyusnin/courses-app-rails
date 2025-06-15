require "rails_helper"

RSpec.describe CoursePolicy, type: :policy do
  let(:admin) { User.new(role: "admin") }
  let(:teacher) { User.new(role: "teacher") }
  let(:student) { User.new(role: "student") }

  subject { described_class }

  permissions :index? do
    it "grants access to admin" do
      expect(subject).to permit(admin, Course.new)
    end

    it "grants access to teacher" do
      expect(subject).to permit(teacher, Course.new)
    end

    it "grants access to student" do
      expect(subject).to permit(student, Course.new)
    end
  end

  permissions :show? do
    it "grants access to admin" do
      expect(subject).to permit(admin, Course.new)
    end

    it "grants access to teacher" do
      expect(subject).to permit(teacher, Course.new)
    end

    it "grants access to student" do
      expect(subject).to permit(student, Course.new)
    end
  end

  permissions :create? do
    it "grants access to admin" do
      expect(subject).to permit(admin, Course.new)
    end

    it "grants access to teacher" do
      expect(subject).to permit(teacher, Course.new)
    end

    it "denies access to student" do
      expect(subject).not_to permit(student, Course.new)
    end
  end

  permissions :update? do
    it "grants access to admin" do
      expect(subject).to permit(admin, Course.new)
    end

    it "grants access to teacher owner of the course" do
      expect(subject).to permit(teacher, Course.new(teacher: teacher))
    end

    it "denies access to teacher" do
      expect(subject).not_to permit(teacher, Course.new)
    end

    it "denies access to student" do
      expect(subject).not_to permit(student, Course.new)
    end
  end

  permissions :destroy? do
    it "grants access to admin" do
      expect(subject).to permit(admin, Course.new)
    end

    it "grants access to teacher owner of the course" do
      expect(subject).to permit(teacher, Course.new(teacher: teacher))
    end

    it "denies access to teacher" do
      expect(subject).not_to permit(teacher, Course.new)
    end

    it "denies access to student" do
      expect(subject).not_to permit(student, Course.new)
    end
  end
end
