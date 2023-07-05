require 'rails_helper'
RSpec.describe 'Users show', type: :feature do
  let!(:user_two) { User.create name: 'Mufti menk', photo: 'http://myphoto', posts_counter: 0 }
  let!(:post_one) do
    Post.create author_id: user_two.id, comments_counter: 0, likes_counter: 0, title: 'My awesome post',
                text: 'something'
  end
  # I can see the user's profile picture.
  it 'should render the users profile picture ' do
    visit "users/#{user_two.id}"
    expect(page).to have_css("img[src*='http://myphoto']")
  end
  # I can see the user's username.
  it 'should render the users name' do
    visit "users/#{user_two.id}"
    expect(page).to have_content(user_two.name)
  end
  # I can see how many posts they have.
  it 'should render the users posts counter' do
    visit "users/#{user_two.id}"
    expect(page).to have_content(user_two.posts_counter)
  end
  it 'should render users bio' do
    visit "users/#{user_two.id}"
    expect(page).to have_content(user_two.bio)
  end
  # I can see the user's first 3 posts.
  it 'should render the users first 3 posts' do
    visit "users/#{user_two.id}"
    user_two.recent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

end