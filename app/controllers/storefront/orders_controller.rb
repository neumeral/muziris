# frozen_string_literal: true

module Storefront
  class OrdersController < StorefrontController
    before_action :authenticate_user!
    before_action :set_order_items, except: [:confirm_order]

    def cart; end

    def add_to_cart
      current_cart.add_item(
        product_id: params[:id],
        quantity: 1
      )
      render :cart
    end

    def update_item
      product_id = @order_items.find(params[:item]).product_id
      current_cart.add_item(
        product_id: product_id,
        quantity: params[:quantity]
      )

      render :cart
    end

    def remove_item
      @order_items.find(params[:item_id]).destroy
      render :cart
    end

    def checkout
      @addresses = current_user.addresses.where(address_type: 'shipping')
      @order = cart_order
    end

    def confirm_order
      address_id = params[:address][:address]
      address = current_user.addresses.find(address_id)
      if cart_order.shipping_address = address
        if params[:payment_method] == 'cod'
          cart_order.payment_method = 'cod'
          payment = Payment.new(
            transaction_id: Payment.generate_cod_transaction_id,
            order_id: cart_order.order_number,
            status: 'initiated',
            payment_gateway: 'COD'
          )

          unless payment.save
            flash[:error] = t('messages.flash.orders.updating_payment_record_failed')
          end
          current_cart.clear
          flash[:success] = t('messages.flash.orders.order_has_successfully_placed')
          redirect_to cart_storefront_orders_path
        else
          redirect_to new_storefront_payment_methods_razorpay_path
        end
      else
        flash[:alert] = t('messages.flash.orders.error_processing_your_request')
        redirect_to cart_storefront_orders_path
      end
    end

    def destroy
      order = current_user.orders.find(params[:id])
      order.status = Order::CANCELLED
      if order.save
        flash.now[:success] = t('messages.flash.orders.order_has_cancelled')
        redirect_to storefront_home_path
      else
        flash[:alert] = t('messages.flash.orders.error_processing_your_request')
        redirect_back fallback_location: storefront_home_path
      end
    end

    private

    def set_order_items
      @order_items = cart_order.items
    end
  end
end
