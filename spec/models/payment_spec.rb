require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:payment) { create(:payment) }

  it 'should have a order_id' do
    payment.order_id = nil
    expect(payment).to_not be_valid
  end

  it 'should have a status' do
    payment.status = nil
    expect(payment).to_not be_valid
  end

  it 'should have a payment_gateway' do
    payment.payment_gateway = nil
    expect(payment).to_not be_valid
  end
end
