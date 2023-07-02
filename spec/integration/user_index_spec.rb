require 'rails_helper'

RSpec.describe 'User index integration spec', type: :system do
  describe 'index page' do
    let!(:user_two) { User.create name: 'Mufti menk', posts_counter: 0 }
    let!(:user_three) { User.create name: 'Dr Zakir', posts_counter: 0 }

    it 'should render the user name' do
      visit users_path
      expect(page).to have_content(user_two.name)
    end

    it 'should render the users photo' do
      visit users_path
      expect(page).to have_content(user_two.photo)
    end

    it 'should render the number of posts' do
      visit users_path
      expect(page).to have_content("Number of posts #{user_two.posts.size}")
    end

    # When I click on a user, I am redirected to that user's show page.
    it 'should redirected to that users show page' do
      visit users_path
      click_on user_two.name
      expect(page).to have_content(user_two.name)
    end
  end
end
