# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::UserPolicy, type: :policy do
  let(:admin) { User.new(role: "admin") }
  let(:teacher) { User.new(role: "teacher") }
  let(:student) { User.new(role: "student") }

  let(:user) { User.new }

  subject { described_class }

  shared_examples "manageable" do
    context "when user is an admin" do
      it "grants access" do
        expect(subject).to permit(admin, User)
      end
    end

    context "when user is teacher" do
      it "denies access" do
        expect(subject).not_to permit(teacher, User)
      end
    end

    context "when user is student" do
      it "denies access" do
        expect(subject).not_to permit(student, User)
      end
    end
  end

  permissions :index? do
    it_behaves_like "manageable"
  end

  permissions :update? do
    it_behaves_like "manageable"
  end

  permissions :destroy? do
    it_behaves_like "manageable"
  end
end
