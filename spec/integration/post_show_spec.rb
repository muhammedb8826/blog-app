require 'rails_helper'

RSpec.describe 'Posts Show', type: :system do
  describe 'Post show page' do
    let!(:user_two) { User.create name: 'Mufti menk', photo: 'http://myphoto', posts_counter: 0 }
    let!(:post_one) do
      Post.create author_id: user_two.id, comments_counter: 0, likes_counter: 0, title: 'My awesome post',
                  text: 'something'
    end
    let!(:post_two) do
      Post.create author_id: user_two.id, comments_counter: 0, likes_counter: 0, title: 'title', text: 'something'
    end

    let!(:comment) { Comment.create author: user_two, post: post_two, text: 'hello', post_id: post_one.id }
    let!(:like) { Like.create author: user_two, post: post_two }

    # I can see the post's title.
    it 'should render the post title' do
      visit "users/#{user_two.id}/posts/#{post_one.id}"
      expect(page).to have_content(post_one.title)
    end

    # I can see who wrote the post.
    it 'should render the post author' do
      visit "users/#{user_two.id}/posts/#{post_one.id}"
      expect(page).to have_content(post_one.author.name)
    end
    # I can see how many comments it has.
    it 'should render the post comments counter' do
      visit "users/#{user_two.id}/posts/#{post_one.id}"
      expect(page).to have_content(post_one.comments_counter)
    end
    # I can see how many likes it has.
    it 'should render the post likes counter' do
      visit "users/#{user_two.id}/posts/#{post_one.id}"
      expect(page).to have_content(post_one.likes_counter)
    end

    # I can see the post body.
    it 'should render the post body' do
      visit "users/#{user_two.id}/posts/#{post_one.id}"
      expect(page).to have_content(post_one.text)
    end

    it 'should render the commentor name and body of the comment' do
      # I can see the username of each commentor
      post_two.comments.each do |comment|
        it 'should render the comment author' do
          visit "users/#{user_two.id}/posts/#{post_one.id}"
          expect(page).to have_content(comment.author.name)
        end
      #I can see the comment each commentor left.
        it 'should render the comment body' do
          visit "users/#{user_two.id}/posts/#{post_one.id}"
          expect(page).to have_content(comment.text)
        end
      end
    end
  end
end
