# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'razorpays', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:app_setting) { create(:app_setting) }

  before :each do
    sign_in user
  end

  describe 'GET /new' do
    it 'returns http success' do
      app_setting
      order
      get '/a/payment_methods/razorpays/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to orders page' do
      app_setting
      order
      create(:payment, order_id: order.order_number)
      post '/a/payment_methods/razorpays', params: {
        razorpay_payment_id: 'pay_EyTkouDAr9DNIY',
        razorpay_order_id: 'order_EyTa0JLvAtG8H9',
        razorpay_signature: 'e4789cb8cfcee2deeea11ef8021fe5095d9bd0e7cec1e4ec863ff55279221490'
      }
      expect(response.location).to include '/a/orders/cart'
    end
  end
end
