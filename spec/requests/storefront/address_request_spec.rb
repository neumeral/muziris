# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Addresses', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:app_setting) { create(:app_setting) }
  let(:address) { create(:address, user_id: user.id) }

  before :each do
    sign_in user
  end

  describe 'GET /new' do
    it 'returns http success' do
      app_setting
      order
      get '/a/addresses/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to accounts page' do
      app_setting
      order
      pre_adresses_count = Address.all.count
      post '/a/addresses', params: { address: {
        address_line1: 'Example Pvt. Ltd',
        address_line2: 'Great Products Street',
        city: 'Kochi',
        zipcode: '682001',
        state: 'Kerala',
        country: 'India',
        phone: '9999888877'
      } }
      expect(Address.all.count).to eq(pre_adresses_count + 1)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      app_setting
      get "/a/addresses/#{address.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      app_setting
      get "/a/addresses/#{address.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      app_setting
      patch "/a/addresses/#{address.id}", params: { address: { address_line2: 'Info park' } }
      expect(response.location).to include('/a/accounts')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      app_setting
      delete "/a/addresses/#{address.id}"
      follow_redirect!
      expect(response.body).to include('Address was successfully destroyed')
    end
  end
end
