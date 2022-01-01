# razor pay payment gateway
module Storefront
  module PaymentMethods
    class RazorpaysController < StorefrontController
      before_action :authenticate_user!
      skip_before_action :verify_authenticity_token, only: [:create]

      def new
        @current_cart = current_cart
        payment = Payment.new(
          order_id: cart_order.order_number,
          status: 'initiated',
          payment_gateway: 'razorpay'
        )
        unless payment.save
          flash[:error] = t('messages.flash.razorpays.updating_payment_record_failed')
        end
        @order = Razorpay::Order.create(
          amount: current_cart.total_amount.to_i * 100,
          currency: AppSetting.instance.currency,
          payment_capture: '0'
        )
      end

      def create
        payment_response = {
          'razorpay_order_id': razor_params[:razorpay_order_id].to_s,
          'razorpay_payment_id': razor_params[:razorpay_payment_id].to_s,
          'razorpay_signature': razor_params[:razorpay_signature].to_s
        }

        Razorpay::Utility.verify_payment_signature(payment_response)
        cart_order.payment_method = 'online_payment'
        payment = Payment.find_by(order_id: cart_order.order_number)
        payment.update(transaction_id: razor_params[:razorpay_payment_id], status: 'success')
        current_cart.clear

        redirect_to cart_storefront_orders_path
      end

      private

      def razor_params
        params.permit(:razorpay_payment_id, :razorpay_order_id, :razorpay_signature)
      end

      def current_cart
        order = current_user.orders.find_by(status: Order::CART)
        ShopingCart.new(order: order)
      end
    end
  end
end
