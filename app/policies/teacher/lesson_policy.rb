# frozen_string_literal: true

module Teacher
  class LessonPolicy < ApplicationPolicy
    def index?
      user.admin? || user.teacher?
    end

    def show?
      user.admin? || owner?
    end

    def new?
      create?
    end

    def create?
      user.admin? || owner?
    end

    def edit?
      update?
    end

    def update?
      user.admin? || owner?
    end

    def destroy?
      user.admin? || owner?
    end

    private

    def owner?
      user.teacher? && record.course.teacher == user
    end
  end
end
