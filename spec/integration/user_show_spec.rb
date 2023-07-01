require 'rails_helper'

RSpec.describe 'Users show', type: :feature do
  let!(:user_two) { User.create name: 'Mufti menk', photo: 'http://myphoto', posts_counter: 0 }
  let!(:post_one) do
    Post.create author_id: user_two.id, comments_counter: 0, likes_counter: 0, title: 'My awesome post', text: 'something'
  end

  it 'should render the users profile picture ' do
    visit "users/#{user_two.id}"
    expect(page).to have_content(user_two.photo)
  end
  




end