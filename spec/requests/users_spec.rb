require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { User.new(name: 'Mufti Menk', photo: 'https://mufti-menk.jpg', bio: 'Muslim scholar', posts_counter: 0) }
  before { subject.save }
  describe 'GET /users' do
    it 'works! (now write some real specs)' do
      get '/users'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index) 
    end
  end
  describe 'GET /users/:id' do
    it 'works! (now write some real specs)' do
      get "/users/#{subject.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
