# frozen_string_literal: true

class StorefrontController < ActionController::Base
  # include StorefrontHelper
  before_action :set_variables
  before_action :check_account_status

  def set_variables
    @categories = Category.all
    @items_count = if current_user
                     current_cart.items_count
                   else
                     0
                   end
  end

  def current_cart
    ShopingCart.new(order: cart_order)
  end

  def cart_order
    current_user.orders.find_or_create_by(status: Order::CART)
  end

  def check_account_status
    if current_user
      return if current_user.active

      sign_out(current_user)
      flash.now[:alert] = t('messages.flash.auth.please_activate_your_account')
    end
  end
end
