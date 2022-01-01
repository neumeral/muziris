require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:order) { create(:order, user_id: user.id) }
  let(:app_setting) { create(:app_setting) }

  before :each do
    sign_in user
  end

  describe 'GET /cart' do
    it 'returns http success' do
      app_setting
      order
      get '/a/orders/cart'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /add_to_cart' do
    it 'returns http success' do
      app_setting
      order
      get "/a/orders/#{product.id}/add_to_cart"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /remove_item' do
    it 'returns http success' do
      app_setting
      get "/a/orders/#{product.id}/add_to_cart"
      item = user.orders.where(status: 'cart', deleted_at: nil).first.items.first
      get '/a/orders/remove_item', params: { item_id: item.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /checkout' do
    it 'returns http success' do
      app_setting
      get '/a/orders/checkout'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /confirm_order' do
    it 'returns http success' do
      app_setting
      address = create(:address, user_id: user.id)
      get '/a/orders/checkout', params: { address: { address: address.id } }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update_item' do
    it 'rener cart' do
      app_setting
      get "/a/orders/#{product.id}/add_to_cart"
      item = user.orders.where(status: 'cart', deleted_at: nil).first.items.first
      patch '/a/orders/update_item', params: { item: item.id, quantity: 3 }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to home page' do
      app_setting
      delete "/a/orders/#{order.id}"
      expect(response.location).to include('/a/home')
    end
  end
end
