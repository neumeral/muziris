# frozen_string_literal: true

# Stripe
module PaymentProvider
  class Stripe
    def initialize(options = {})
      @params = options[:params]
      @amount = options[:amount]
    end

    def call
      # Authorize for $10 dollars (1000 cents)
      gateway.authorize(@amount, 'tok_visa', purchase_options)
    end

    def purchase_options
      {
        billing_address: {
        },
        currency: AppSetting.instance.currency
      }
    end

    def token
      Stripe::Token.create({
                             card: {
                               number: @params[:card_number],
                               exp_month: @params['card_expires_on(2i)'],
                               exp_year: @params['card_expires_on(1i)'],
                               cvc: @params[:card_verification]
                             }
                           })
    end

    def gateway
      ActiveMerchant::Billing::StripeGateway.new(
        login: Rails.application.credentials.dig(:stripe, :secret_key)
      )
    end
  end
end
