require_relative '../rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before do
      get '/users'
    end

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders template index' do
      expect(response).to render_template(:index)
    end
  end
end
