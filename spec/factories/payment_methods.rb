FactoryBot.define do
  factory :payment_method do
    name { 'Spreedly' }
    description { 'Nothing' }
    provider { 'PaymentProvider::Spreedly' }
    active { true }
  end
end
