# frozen_string_literal: true

module PaymentProvider
  # PayU india
  class PayUIn
    def initialize(options = {})
      @amount = options[:amount]
      @payment_option = options[:payment_option]
    end

    def call
      # Authorize for $10 dollars (1000 cents)
      gateway.authorize(@amount, @payment_option, purchase_options)
    end

    def purchase_options
      {
        billing_address: {
        },
        currency: AppSetting.instance.currency
      }
    end

    def gateway
      ActiveMerchant::Billing::PayuInGateway.new(
        key: Rails.application.credentials.dig(:payuin, :key),
        salt: Rails.application.credentials.dig(:payuin, :salt),
        auth_header: Rails.application.credentials.dig(:payuin, :auth_header)
      )
    end
  end
end
