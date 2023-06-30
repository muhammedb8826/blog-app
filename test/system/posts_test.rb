require 'application_system_test_case'
# require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'User post index page' do
    let(:user) { User.create(name: 'Tango', photo: 'http://myphoto') }
    let(:first_post) { Post.create(author: user, title: 'blablabla', text: 'blablabla') }
    let(:second_post) { Post.create(author: user, title: 'dewdew', text: 'dewdewdew') }
    let(:comment) { Comment.create(user:, post: first_post, text: 'Nice one') }
    let(:like) { Like.create(user:, post: first_post) }
    before(:each) do
      comment.save
      like.update_likes_counter
    end

    it 'shows the basic info for the user' do
      visit user_posts_path(user_id: user.id)

      # I can see the user's username.
      expect(page).to have_content(user.name)
      # I can see the number of posts the user has written.
      expect(page).to have_content("Number of posts #{user.posts.size}")
      # I can see a post's title.
      expect(page).to have_content(first_post.title)
      # I can see some of the post's body.
      expect(page).to have_content(first_post.text)
      # I can see the first comments on a post.
      expect(page).to have_content(comment.text)
      # I can see how many comments a post has.
      expect(page).to have_css('h3', text: "Comments: #{first_post.comments.count}")
      # I can see how many likes a post has.
      expect(page).to have_css('span.post-footer',
                               text: "Comments: #{first_post.comments_counter}, Likes: #{first_post.likes_counter}")
      # I can see a section for pagination if there are more posts than fit on the view.
      expect(page).to have_button('Pagination')
    end

    it "redirects me to that post's show page When I click on a post." do
      visit user_posts_path(user_id: user.id)
      click_link first_post.title
      expect(page).to have_current_path(user_post_path(user_id: user.id, id: first_post.id))
    end
  end

  describe 'Post show page' do
    let(:user) { User.create(name: 'Tango', photo: 'http://myphoto') }
    let(:first_post) { Post.create(author: user, title: 'blablabla', text: 'blablabla') }
    let(:second_post) { Post.create(author: user, title: 'dewdew', text: 'dewdewdew') }
    let(:comment) { Comment.create(user:, post: first_post, text: 'Nice one') }
    let(:like) { Like.create(user:, post: first_post) }
    before(:each) do
      comment.save
      like.update_likes_counter
    end

    it 'shows the post info' do
      visit user_post_path(user_id: user.id, id: first_post.id)
      # I can see the post's title.
      expect(page).to have_content(first_post.title)
      # I can see who wrote the post.
      expect(page).to have_content(first_post.author.name)
      # I can see how many comments it has.
      expect(page).to have_css('h3', text: "Comments: #{first_post.comments.count}")
      # I can see how many likes it has.
      expect(page).to have_css('span.post-header',
                               text: "Comments: #{first_post.comments_counter}, Likes: #{first_post.likes_counter}")
      # I can see the post body.
      expect(page).to have_content(first_post.text)
      # I can see the username of each commentor.
      first_post.comments.each do |cm|
        expect(page).to have_content(cm.user.name)
        # I can see the comment each commentor left.
        expect(page).to have_content(cm.text)
      end
    end
  end
end