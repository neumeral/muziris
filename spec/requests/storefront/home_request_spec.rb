require 'rails_helper'

RSpec.describe 'Home', type: :request do
  let(:user) { create(:user) }
  let(:app_setting) { create(:app_setting) }

  before :each do
    sign_in user
  end

  describe 'GET /show' do
    it 'returns http success' do
      app_setting
      get '/a/home'
      expect(response).to have_http_status(:success)
    end
  end
end
