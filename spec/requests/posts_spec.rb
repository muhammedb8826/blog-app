require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create name: 'Dr Zakir', posts_counter: 0 }
  let!(:post) do
    Post.create author_id: user.id, comments_counter: 0, likes_counter: 0, title: 'My awesome post', text: 'something'
  end

  describe 'GET /posts' do
    it 'works! (now write some real specs)' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /posts/:id' do
    it 'works! (now write some real specs)' do
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
