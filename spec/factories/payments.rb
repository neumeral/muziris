# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    transaction_id { 'cs_dsfDfFnj' }
    order_id { 'order_dgfdkf' }
    status { 'success' }
    payment_gateway { 'razorpay' }
  end
end
