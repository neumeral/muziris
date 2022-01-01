class OrderPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user
  end

  def update?
    user.admin?
  end

  def edit?
    update? && user.admin?
  end

  def search?
    true
  end
end
