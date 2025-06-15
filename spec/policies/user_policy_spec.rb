# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :index? do
    context "when user is an admin" do
      let(:admin) { User.new(role: "admin") }

      it "grants access" do
        expect(subject).to permit(admin, User)
      end
    end

    context "when user is teacher" do
      let(:teacher) { User.new(role: "teacher") }

      it "denies access" do
        expect(subject).not_to permit(teacher, User)
      end
    end

    context "when user is student" do
      let(:student) { User.new(role: "student") }

      it "denies access" do
        expect(subject).not_to permit(student, User)
      end
    end
  end

  permissions :update? do
    context "when user is an admin" do
      let(:admin) { User.new(role: "admin") }

      it "grants access" do
        expect(subject).to permit(admin, User)
      end
    end

    context "when user is teacher" do
      let(:teacher) { User.new(role: "teacher") }

      it "denies access" do
        expect(subject).not_to permit(teacher, User)
      end
    end

    context "when user is student" do
      let(:student) { User.new(role: "student") }

      it "denies access" do
        expect(subject).not_to permit(student, User)
      end
    end
  end

  permissions :destroy? do
    context "when user is an admin" do
      let(:admin) { User.new(role: "admin") }

      it "grants access" do
        expect(subject).to permit(admin, User)
      end
    end

    context "when user is teacher" do
      let(:teacher) { User.new(role: "teacher") }

      it "denies access" do
        expect(subject).not_to permit(teacher, User)
      end
    end

    context "when user is student" do
      let(:student) { User.new(role: "student") }

      it "denies access" do
        expect(subject).not_to permit(student, User)
      end
    end
  end
end
