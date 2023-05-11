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

  describe 'GET /users/:id' do
    before do
      User.create!(id: 1,
                   name: 'John Doe',
                   bio: 'I am John Doe',
                   photo: 'https://www.google.com',
                   postscounter: 0)
      get '/users/1'
    end

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders template show' do
      expect(response).to render_template(:show)
    end
  end
end
