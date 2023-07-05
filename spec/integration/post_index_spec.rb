require 'rails_helper'
RSpec.describe 'post#index', type: :system do
  let!(:user_two) { User.create name: 'Mufti menk', photo: 'http://myphoto', posts_counter: 0 }
  let!(:user_three) { User.create name: 'Dr Zakir', photo: 'http://myphoto', posts_counter: 0 }
  let!(:post) do
    Post.create author_id: user_two.id, comments_counter: 0, likes_counter: 0, title: 'My awesome post',
                text: 'something'
  end
  let!(:post_two) do
    Post.create author_id: user_three.id, comments_counter: 0, likes_counter: 0, title: 'title', text: 'something'
  end
  let!(:comment) { Comment.create author: user_two, post: post_two, text: 'hello' }
  let!(:comment_two) { Comment.create author: user_two, post: post_two, text: 'hello' }
  let!(:comment_three) { Comment.create author: user_two, post: post_two, text: 'hello' }
  let!(:comment_four) { Comment.create author: user_two, post: post_two, text: 'hello' }
  let!(:comment_five) { Comment.create author: user_two, post: post_two, text: 'hello' }
  let!(:comment_six) { Comment.create author: user_two, post: post_two, text: 'hello' }

  # I can see the user's profile picture.
  it 'should render the user profile picture' do
    visit "users/#{user_two.id}/posts"
    expect(page).to have_css("img[src*='http://myphoto']")
  end

  # I can see the user's username.
  it 'should render the user name' do
    visit "users/#{user_two.id}/posts"
    expect(page).to have_content(user_two.name)
  end
  # I can see the number of posts the user has written.
  it 'should render the number of posts' do
    visit "users/#{user_two.id}/posts"
    expect(page).to have_content("Number of posts #{user_two.posts.size}")
  end
  # I can see a post's title.
  it 'should render the post title' do
    visit "users/#{user_two.id}/posts"
    expect(page).to have_content(post.title)
  end
  # I can see some of the post's body.
  it 'should render some of the post text' do
    visit "users/#{user_two.id}/posts"
    expect(page).to have_content(post.text.slice(0..10))
  end
  # I can see the first comments on a post.
  it 'should render the firsts comments' do
    visit "users/#{user_two.id}/posts"
    comments = find_all('.comment')
    expect(comments.count).to be < 6
  end
  # I can see how many comments a post has.
  it 'should render the number of comments' do
    visit "users/#{user_two.id}/posts"
    element = find_by_id("comments_post_#{post.id}")
    expect(element).to have_content("Number of comments #{post.comments_counter}")
  end
  # I can see how many likes a post has.
  it 'should render the number of likes' do
    visit "users/#{user_two.id}/posts"
    element = find_by_id("likes_post_#{post.id}")
    expect(element).to have_content("Likes: #{post.likes_counter}")
  end
  # I can see a section for pagination if there are more posts than fit on the view.
  it 'should render pagination if the post has more than 5 comments' do
    visit "users/#{user_three.id}/posts"
    expect(page).to have_content('See all comments')
  end
  # The link redirect to the diesred location
  context 'post detail link' do
    it 'post detail link should redirect to that post detail' do
      visit "users/#{user_two.id}/posts"
      click_link href: "/users/#{user_two.id}/posts/#{post.id}"
      expect(page).to have_current_path("/users/#{user_two.id}/posts/#{post.id}")
    end
  end
end
