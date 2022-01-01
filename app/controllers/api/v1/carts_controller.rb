module Api::V1
  class CartsController < ApiController
    before_action :cart_order
    before_action :set_order_items, only: [:update_item, :remove_item]

    def add_item
      # Order is set by set_order, else build new
      current_cart.add_item(
        product_id: order_item_params[:product_id],
        quantity: order_item_params[:quantity]
      )
      render_json(@order)
    end

    def show
      render_json(@order)
    end

    def update_item
      product_id = @order_items.find(params[:item]).product_id
      current_cart.add_item(
        product_id: product_id,
        quantity: params[:quantity]
      )

      render_json(@order)
    end

    def remove_item
      @order_items.find(params[:item_id]).destroy
      render_json(@order)
    end

    def update
      if cart_params[:shipping_address_id]
        shipping_address = Address.find(cart_params[:shipping_address_id])
        @order.shipping_address = shipping_address
      end
      if cart_params[:billing_address_id]
        billing_address = Address.find(cart_params[:billing_address_id])
        @order.billing_address = billing_address
      end
      if cart_params[:payment_method]
        payment_method = cart_params[:payment_method]
        if PaymentMethod.find_by(code: payment_method)
          @order.payment_method = payment_method
        end
      end
      if @order.save
        render_json(@order)
      else
        render json: { success: false, message: 'failed to update cart' }
      end
    end

    def finalize
      if @order&.update(status: Order::CONFIRMED)
        render_json(@order)
      else
        render json: { success: false, message: @order.errors.full_messages.to_sentance }
      end
    end

    def destroy
      if @order&.update(deleted_at: Time.now)
        render_json(@order)
      else
        render json: { success: false, message: 'cart not found' }
      end
    end

    private

    def render_json(cart = nil)
      if cart
        serializer = OrderSerializer.new(cart)
        render json: serializer
      else
        render json: { success: false }
      end
    end

    def current_cart
      @current_cart ||= ShopingCart.new(order: @order)
    end

    def cart_order
      @order = current_user.orders.find_or_create_by(status: Order::CART)
    end

    def set_order_items
      @order_items = cart_order.items
    end

    def cart_params
      params.require(:cart).permit(
        :order_number, :status, :sub_total, :user_id,
        :token, :shipping_address_id, :billing_address_id, :payment_method
      )
    end

    def order_item_params
      params.require(:cart).permit(:product_id, :quantity)
    end

    def cart_token
      @cart_token ||= SecureRandom.hex(8)
    end
  end
end
