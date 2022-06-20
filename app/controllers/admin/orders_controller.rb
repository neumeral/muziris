# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    include Pagy::Backend
    before_action :set_order, except: [:index, :search, :payment_done]
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def index
      @pagy, @orders = pagy(Order.all.order(deleted_at: :desc).order(user_id: :desc))
    end

    def show; end

    def edit; end

    def update
      if @order.update(order_params)
        redirect_to admin_order_path(@order),
                    notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    def done_payment
      payment = Payment.find_by(order_id: @order.order_number)
      if payment.update(status: 'success')
        flash.now[:success] = t('messages.flash.payment.payment_success')
      else
        flash.now[:error] = t('messages.flash.error.common_error_message')
      end
      redirect_back fallback_location: storefront_home_path
    end

    def search
      if params[:q].present?
        value = params[:q]
        @pagy, @orders = pagy(Order.search_by_term(value))
      else
        @orders = Order.all
      end
      render :index
    end

    private

    def order_params
      params.require(:order).permit(:order_number, :status, :total_amount, :user_id, :token)
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
