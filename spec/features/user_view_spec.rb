require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'index page' do

    # Run before each test case
    before(:each) do
      @user = User.create(
        name: 'Raymond',
        bio: 'Software Developer',
        photo: 'http://myviews.com/org.jpg',
        posts_counter: 1
      )
    end

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
  

  # Test block for user show page
  describe 'show page' do
    before(:each) do
      @user =
        User.create(
          name: 'Raymond',
          bio: 'Software Developer',
          photo: 'http://myviews.com/org.jpg',
          posts_counter: 0
        )

      # Create post instances with required parameters
      @post = Post.create(title: 'User first post', text: 'Sport', author_id: @user.id, comments_counter: 0,
                          likes_counter: 0)
      @post_second = Post.create(title: 'User second post', text: 'Entertainment', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      @post_third = Post.create(title: 'User third post', text: 'Politics', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
    end

    it "should contain users's profile picture." do

      # Expect the page to have an image selector
      page.has_selector?('img')
    end

    it "should show users's username." do
      visit user_path(@user.id)
      expect(page).to have_content('Raymond')
    end

    it 'should show users number of posts' do
      visit user_path(@user.id)
      expect(page).to have_content('Number of Posts: 3')
    end

    it "show users's bio." do
      visit user_path(@user.id)
      expect(page).to have_content('Software Developer')
    end

    # User show page contains last three posts
    it 'has recent three posts' do
      visit user_path(@user.id)
      expect(page).to have_content('Sport')
      expect(page).to have_content('Entertainment')
      expect(page).to have_content('Politics')
    end

    it 'Should show button or link to all posts' do
      visit user_path(@user.id)
      expect(page).to have_selector(:link_or_button, 'See all Posts')
    end

    # it should redirect to that post's show page when users post is clicked.
    it 'redirects to user post show page' do
      visit user_posts_path(@user.id)
      expect(page).to have_current_path user_posts_path(@user.id)
    end

    # it should redirect to the user's post's index page when see all posts is clicked
    it 'redirects to all user post index page' do
      visit user_path(@user.id)
      click_link 'See all Posts'
      expect(page).to have_current_path user_posts_path(@user.id)
    end
  end
end
