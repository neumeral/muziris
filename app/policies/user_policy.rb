# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || user
  end

  def create?
    user.admin?
  end

  def new?
    create? && user.admin?
  end

  def update?
    user.admin? || user
  end

  def edit?
    update? && user.admin?
  end

  def destroy?
    user.admin? || user
  end

  def search?
    true
  end
end
