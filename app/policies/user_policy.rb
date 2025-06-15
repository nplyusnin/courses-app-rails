# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    manage?
  end

  def show?
    manage?
  end

  def edit?
    update?
  end

  def update?
    manage?
  end

  def destroy?
    manage?
  end

  private

  def manage?
    user.admin?
  end
end
