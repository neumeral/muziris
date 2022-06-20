# frozen_string_literal: true

module PaymentProvider
  # Spreedly
  class Spreedly
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
      ActiveMerchant::Billing::SpreedlyCoreGateway.new(
        login: Rails.application.credentials.dig(:spreedly, :login),
        password: Rails.application.credentials.dig(:spreedly, :password),
        gateway_token: Rails.application.credentials.dig(:spreedly, :gateway_token)
      )
    end
  end
end
