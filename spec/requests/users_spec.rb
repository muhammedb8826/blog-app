require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { User.new(name: 'Mufti Menk', photo: 'https://mufti-menk.jpg', bio: 'Muslim scholar', posts_counter: 0) }
  before { subject.save }
  describe 'GET /users' do
    it 'works! (now write some real specs)' do
      get '/users'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('Hello Rails developer')
    end
  end
  describe 'GET /users/:id' do
    it 'works! (now write some real specs)' do
      get user_path(1)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('User 1')
    end
  end
end
