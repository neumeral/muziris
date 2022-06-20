# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:app_setting) { create(:app_setting) }

  before :each do
    sign_in user
  end

  describe 'GET /show' do
    it 'returns http success' do
      app_setting
      order
      get '/a/payment_methods/razorpays/new'
      expect(response).to have_http_status(:success)
    end
  end
end
