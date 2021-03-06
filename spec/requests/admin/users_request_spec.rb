require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/users/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/users', params: { user: {
        name: 'user',
        email: 'user@gmail.com',
        password: 'password',
        password_confirmation: 'password',
        admin: true
      } }
      expect(response.location).to include '/admin/users'
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/users/#{user.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/users/#{user.id}", params: { user: { name: 'yadu' } }
      expect(response.location).to include "/admin/users/#{user.id}"
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/users/#{user.id}"
      expect(response.location).to include '/admin/users'
    end
  end

  describe 'GET /search' do
    it 'render to index page' do
      create(:user, email: 'syam@gmail.com', name: 'Syam')
      get '/admin/users/search', params: { q: 'Syam' }
      expect(response.body).to include('Syam')
    end
  end

  describe 'GET /reset_password' do
    it 'render to index page' do
      get "/admin/users/#{user.id}/reset_password"
      follow_redirect!
      expect(response.body).to include('Password reset link has been sent')
    end
  end
end
