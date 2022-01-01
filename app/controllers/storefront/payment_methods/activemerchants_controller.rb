# active merchant gateway
module Storefront
  module PaymentMethods
    class ActivemerchantsController < StorefrontController
      before_action :authenticate_user!
      skip_before_action :verify_authenticity_token, only: [:create]

      def credit_card
        credit_card ||= ActiveMerchant::Billing::CreditCard.new(
          first_name: activemerchants_params[:first_name],
          last_name: activemerchants_params[:last_name],
          month: activemerchants_params['card_expires_on(2i)'],
          year: activemerchants_params['card_expires_on(1i)'],
          brand: activemerchants_params[:card_type],
          number: activemerchants_params[:card_number],
          verification_value: activemerchants_params[:card_verification]
        )
        pay(credit_card)
      end

      def pay(payment_option)
        amount = cart_order.total_amount.to_i
        params = {
          params: activemerchants_params,
          payment_option: payment_option,
          amount: amount
        }
        payment = Payment.new(
          order_id: cart_order.order_number,
          status: 'initiated',
          payment_gateway: PaymentMethod.active_provider
        )

        unless payment.save
          flash[:error] = t('messages.flash.razorpays.updating_payment_record_failed')
        end

        if payment_option.valid?
          payment_service = PaymentService.new.payment_service(params)
          response = payment_service.call
          gateway = payment_service.gateway

          if response.success?
            # Capture the money
            gateway.capture(amount, response.authorization)

            payment = Payment.find_by(order_id: cart_order.order_number)
            payment.update(transaction_id: response.authorization.to_s, status: 'success')
            current_cart.clear
            redirect_to cart_storefront_orders_path
          else
            raise StandardError, response.message
          end
        else
          payment_option.errors.full_messages.each do |message|
            errors.add_to_base message
          end
        end
      end

      private

      def payment_method
        payment_method = PaymentMethod.where(active: true).order('updated_at').last
        payment_method.provider
      end

      def activemerchants_params
        params.require(:credit_card).permit(
          :first_name, :last_name, :card_type,
          :card_number, :card_verification,
          :card_expires_on, 'card_expires_on(1i)',
          'card_expires_on(2i)', 'card_expires_on(3i)'
        )
      end

      def current_cart
        order = current_user.orders.find_by(status: Order::CART)
        ShopingCart.new(order: order)
      end
    end
  end
end
