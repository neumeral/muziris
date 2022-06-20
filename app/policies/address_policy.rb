# frozen_string_literal: true

class AddressPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user
  end

  def create?
    user
  end

  def new?
    create? && user.admin?
  end

  def update?
    user
  end

  def edit?
    update? && user.admin?
  end

  def destroy?
    user
  end
end
