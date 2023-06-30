# require 'rails_helper'

# RSpec.describe 'Users', type: :system do
#   describe 'index page' do
#     before(:each) do
#       User.create(name: 'Tango', photo: 'http://myphoto')
#       User.create(name: 'Mango', photo: 'http://muftisphoto')
#     end
#     let(:users) { User.all }
#     it 'shows the right content' do
#       visit users_path
#       users.each do |user|
#         expect(page).to have_content(user.name)
#       end
#     end

#     it 'shows the correct photo' do
#       visit users_path
#       users.each do |user|
#         expect(page).to have_css("img[src*='#{user.photo}']")
#       end
#     end

#     it 'shows posts counter' do
#       visit users_path
#       users.each do |user|
#         expect(page).to have_selector('sub', text: user.posts.count)
#       end
#     end
#   end

#   describe 'users show' do
#     let(:user) { User.new(name: 'Tango', photo: 'http://myphoto') }
#     let(:post) { Post.new(author: user, title: 'His first dawah', text: 'His first dawah') }

#     before(:each) do
#       user.save
#       post.save
#     end

#     it "shows the user's profile picture." do
#       visit user_path(user.id)
#       expect(page).to have_css("img[src*='#{user.photo}']")
#     end

#     # I can see the user's username.
#     it "shows the user's username." do
#       visit user_path(user.id)
#       expect(page).to have_content(user.name)
#     end

#     it 'shows the number of posts the user has written.' do
#       visit user_path(user.id)
#       expect(page).to have_selector('a.post-card', count: 1)
#     end

#     it "shows the user's bio." do
#       visit user_path(user.id)
#       expect(page).to have_content(user.bio)
#     end

#     # I can see the user's first 3 posts.
#     it "shows the user's first 3 posts." do
#       visit user_path(user.id)
#       user.most_recent_posts.each do |post|
#         expect(page).to have_content(post.title)
#       end
#     end
#     # I can see a button that lets me view all of a user's posts.
#     it "shows a button that lets me view all of a user's posts." do
#       visit user_path(user.id)
#       expect(page).to have_selector('a.show-all-posts-button')
#     end
#   end

#   describe 'checks the links' do
#     before(:each) do
#       user = User.create(name: 'Tango', photo: 'http://myphoto')
#       Post.create(author: user, title: 'His first dawah', text: 'His first dawah')
#     end
#     let(:user) { User.first }
#     let(:post) { user.posts[0] }
#     it 'the user is redirected to the correct url' do
#       visit users_path

#       click_link user.name
#       expect(current_path).to eq("/users/#{user.id}")
#     end

#     it "redirects me to post's show page When I click a user's post." do
#       visit user_path(user.id)

#       click_link post.title
#       expect(current_path).to eq("/users/#{user.id}/posts/#{post.id}")
#     end
#     it "redirects me to the user's post's index page When I click to see all posts" do
#       visit user_path(user.id)

#       click_link 'Show all posts'
#       expect(current_path).to eq("/users/#{user.id}/posts")
#     end
#   end
# end