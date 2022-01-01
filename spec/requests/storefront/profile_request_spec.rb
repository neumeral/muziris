require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { create(:user) }
  let(:app_setting) { create(:app_setting) }

  before :each do
    sign_in(user, scope: :user)
  end

  describe 'GET /edit' do
    it 'returns http success' do
      app_setting
      get "/a/profiles/#{user.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      app_setting
      create(:user, email: 'yadav666@gmail.com')
      sign_in(user, scope: :user)
      get "/a/profiles/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      app_setting
      patch "/a/profiles/#{user.id}", params: { user: { name: 'vijay' } }
      expect(response.location).to include('/a/profile')
      follow_redirect!
      expect(response.body).to include('Successfully updated user profile.')
    end
  end
end
