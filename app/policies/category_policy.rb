class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user
  end

  def create?
    user.admin?
  end

  def new?
    create? && user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    update? && user.admin?
  end

  def destroy?
    user.admin?
  end

  def search?
    true
  end
end
