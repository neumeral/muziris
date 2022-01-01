class BannerItemPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user.admin?
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
end
