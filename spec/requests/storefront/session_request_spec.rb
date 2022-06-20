# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sessions', type: :request do
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
      get '/a/sessions/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to orders page' do
      app_setting
      order
      post '/a/sessions', params: { session: {
        email: 'user@example.com'
      } }
      expect(response.location).to include '/a/sessions/otp'
    end
  end
end
