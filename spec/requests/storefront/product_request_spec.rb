require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:user) { create(:user) }
  let(:app_setting) { create(:app_setting) }
  let(:product) { create(:product) }

  before :each do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      app_setting
      get '/a/products'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      app_setting
      get "/a/products/#{product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /search' do
    it 'returns http success' do
      app_setting
      get '/a/products/search', params: { section: { term: product.name } }
      expect(response.body).to include(product.name)
    end
  end
end
