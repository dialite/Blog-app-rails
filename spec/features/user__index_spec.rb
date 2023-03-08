require 'rails_helper'

RSpec.describe 'Index page', type: :system do
  
  # Run before each test case
  before(:each) do
    @user = User.create(
      name: 'Raymond',
      bio: 'Software Developer',
      photo: 'http://myviews.com/org.jpg',
      posts_counter: 1
    )
  end

  describe 'index page' do
    it 'should show the username of the users' do

      # Visit the index page
      visit users_path
      expect(page).to have_content('Raymond')
    end

    it 'should show the profile picture of each user' do
      visit users_path

      # Expect the page to have an image selector
      page.has_selector?('img')
    end

    it 'should show the number of users post' do
      visit users_path
      expect(page).to have_content('Number of Posts: 1')
    end

    it 'should redirect to users show page when a user is clicked' do

      # Visit the show page of the user
      visit user_path(@user.id)

      # Expect the show page to have the user's name and bio
      expect(page).to have_content('Raymond')
      expect(page).to have_content('Software Developer')
    end
  end
end
