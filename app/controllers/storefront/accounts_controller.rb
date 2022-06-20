# frozen_string_literal: true

module Storefront
  class AccountsController < StorefrontController
    include Pagy::Backend
    before_action :authenticate_user!

    def show
      @pagy, @shipping_addresses = pagy(current_user.addresses.where(address_type: 'shipping'))
      @pagy, @billing_addresses = pagy(current_user.addresses.where(address_type: 'billing'))
      @pagy, @order_history = pagy(current_user.orders
        .where('status != ?', 'cart').order(created_at: :desc))
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
