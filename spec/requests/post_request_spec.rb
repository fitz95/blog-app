require_relative '../rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:id/posts' do
    before do
      User.create!(id: 1,
                   name: 'John Doe',
                   bio: 'I am John Doe',
                   photo: 'https://www.google.com',
                   postscounter: 0)
      get '/users/1/posts'
    end

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders template index' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    before do
      User.create!(id: 1,
                   name: 'Fitz Gerald',
                   bio: 'I am Fitz Gerald',
                   photo: 'https://via.placeholder.com/150',
                   postscounter: 0)
      Post.create!(id: 1,
                   author_id: 1,
                   title: 'The Black Cat',
                   text: 'This noveli is about an antique inspector that does his best to recover stolen artefacts',
                   commentscounter: 0,
                   likescounter: 0)
      get '/users/1/posts/1'
    end

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns http success response' do
      expect(response).to have_http_status(200)
    end

    it 'renders template show' do
      expect(response).to render_template(:show)
    end
  end
end
