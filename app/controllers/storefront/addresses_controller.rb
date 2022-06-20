# frozen_string_literal: true

module Storefront
  class AddressesController < StorefrontController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def new
      @address = Address.new
    end

    def create
      @address = current_user.addresses.new(address_params)
      if @address.save
        if params[:commit] == 'Checkout'
          payment_method = params[:payment_method]
          redirect_to confirm_order_storefront_orders_path(
            address: { address: @address.id },
            payment_method: payment_method
          )

        else
          redirect_to storefront_accounts_path
        end
      else
        redirect_back fallback_location: root_path
      end
    end

    def edit; end

    def update
      if @address.update(address_params)
        flash[:success] = t('messages.flash.addresses.address_was_successfully_updated')
        redirect_to storefront_accounts_path
      else
        redirect_to root_path
      end
    end

    def destroy
      if @address.destroy
        flash[:success] = t('messages.flash.addresses.address_was_successfully_destroyed')
      else
        flash[:error] = t('messages.flash.addresses.error_processing_your_request')
      end
      redirect_back fallback_location: root_path
    end

    private

    def set_address
      @address = current_user.addresses.find(params[:id])
    end

    def address_params
      params.require(:address).permit(
        :id, :address_line1, :address_line2,
        :city, :zipcode, :state, :country, :phone,
        :user_id, :is_default, :address_type
      )
    end
  end
end
