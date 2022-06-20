require "active_merchant"


ActiveMerchant::Billing::Base.mode = :test
ActiveMerchant::Billing::Base.mode = :development

::GATEWAY = ActiveMerchant::Billing::TrustCommerceGateway.new(
              login: Rails.application.credentials.dig(:activemerchant, :login),
              password: Rails.application.credentials.dig(:activemerchant, :password)
            )
