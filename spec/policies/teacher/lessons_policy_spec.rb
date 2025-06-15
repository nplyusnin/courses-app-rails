# frozen_string_literal: true

require "rails_helper"

RSpec.describe Teacher::LessonPolicy, type: :policy do
  let(:admin) { User.new(role: "admin") }
  let(:teacher) { User.new(role: "teacher") }
  let(:student) { User.new(role: "student") }

  let(:course) { Course.new }
  let(:teacher_course) { Course.new(teacher: teacher) }

  let(:lesson) { Lesson.new(course:) }
  let(:teacher_lesson) { Lesson.new(course: teacher_course) }

  subject { described_class }

  shared_examples "createable" do
    it "grants access to admin" do
      expect(subject).to permit(admin, lesson)
    end

    it "grants access to teacher" do
      expect(subject).to permit(teacher, lesson)
    end

    it "denies access to student" do
      expect(subject).to_not permit(student, lesson)
    end
  end

  shared_examples "manageable" do
    it "grants access to admin" do
      expect(subject).to permit(admin, lesson)
    end

    it "grants access to teacher owner" do
      expect(subject).to permit(teacher, teacher_lesson)
    end

    it "denies access to teacher on different course" do
      expect(subject).to_not permit(teacher, lesson)
    end

    it "denies access to student" do
      expect(subject).to_not permit(student, lesson)
    end
  end

  permissions "index?" do
    it_behaves_like "createable"
  end

  permissions "show?" do
    it_behaves_like "manageable"
  end

  permissions "create?" do
    it_behaves_like "manageable"
  end

  permissions "update?" do
    it_behaves_like "manageable"
  end

  permissions "destroy?" do
    it_behaves_like "manageable"
  end
end
