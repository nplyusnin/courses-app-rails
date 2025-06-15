class CoursePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  def index?
    show?
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user.admin? || user.teacher?
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
    user.teacher? && record.teacher == user
  end
end
