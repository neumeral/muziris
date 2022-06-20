# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Activemerchants', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:app_setting) { create(:app_setting) }

  before :each do
    sign_in user
  end

  describe 'POST /credit_card' do
    it 'redirect to orders page' do
      app_setting
      order
      create(:payment_method)
      post '/a/payment_methods/activemerchants/credit_card', params: { credit_card: {
        first_name: 'yadu',
        last_name: 'dev',
        card_type: 'visa',
        card_number: '4111111111111111',
        card_verification: '000',
        "card_expires_on(1i)": '2030',
        "card_expires_on(2i)": '6',
        "card_expires_on(3i)": '1'
      } }
      expect(response.location).to include '/a/orders/cart'
      follow_redirect!
    end
  end
end
