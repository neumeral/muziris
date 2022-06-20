# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:user) { create(:user) }
  let(:app_setting) { create(:app_setting) }
  let(:category) { create(:category) }

  before :each do
    sign_in user
  end

  describe 'GET /show' do
    it 'returns http success' do
      app_setting
      get "/a/categories/#{category.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
