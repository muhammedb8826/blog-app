require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'works! (now write some real specs)' do
      get '/users/1/posts'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('This is from post page')
    end
  end
  describe 'GET /posts/:id' do
    it 'works! (now write some real specs)' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('Post 1')
    end
  end
end
