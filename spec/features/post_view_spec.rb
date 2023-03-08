require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'content' do
    before(:each) do
      @user =
        User.create(name: 'Raymond', bio: 'Software Developer', photo: 'http://myviews.com/org.jpg',
                    posts_counter: 0)
      @post_first =
        Post.create(title: 'Technology', text: 'Latest technological trends', author_id: @user.id,
                    comments_counter: 0, likes_counter: 0)
      @post_second =
        Post.create(title: 'Sports', text: 'First class football clubs', author_id: @user.id,
                    comments_counter: 0, likes_counter: 0)
      @post_third =
        Post.create(title: 'Programming', text: 'Favourite programming language', author_id: @user.id,
                    comments_counter: 0, likes_counter: 0)
      Comment.create(text: 'The 5G technology is a master piece', author_id: @user.id, post_id: @post_first.id)
      Comment.create(text: 'I admire latest technological innovations', author_id: @user.id, post_id: @post_first.id)
      Comment.create(text: 'European football clubs are very good', author_id: @user.id, post_id: @post_second.id)
      Comment.create(text: 'Financial capacity also define class', author_id: @user.id, post_id: @post_second.id)
      Comment.create(text: 'Python is a cool language with english syntax', author_id: @user.id,
                     post_id: @post_third.id)
      Comment.create(text: 'I am currently enjoying Ruby on Rails', author_id: @user.id, post_id: @post_third.id)
      Like.create(post_id: @post_first.id, author_id: @user.id)
      Like.create(post_id: @post_second.id, author_id: @user.id)
      Like.create(post_id: @post_third.id, author_id: @user.id)
    end

    describe 'index page' do
      it "should show user's profile picture." do
        # Expect the page to have an image selector
        page.has_selector?('img')
      end

      it "should show the user's username." do
        visit user_posts_path(@user.id)
        expect(page).to have_content('Raymond')
      end

      it 'should show the number of posts each user has written.' do
        visit user_posts_path(@user.id)
        expect(page).to have_content(3)
      end

      it "should show the a post's title." do
        visit user_posts_path(@user.id)
        expect(page).to have_content('Technology')
        expect(page).to have_content('Sports')
        expect(page).to have_content('Programming')
      end

      it "Should show of the post's body." do
        visit user_posts_path(@user.id)
        expect(page).to have_content('Latest technological trends')
        expect(page).to have_content('First class football clubs')
        expect(page).to have_content('Favourite programming language')
      end

      it 'should show the first comments on a post.' do
        visit user_posts_path(@user.id)
        expect(page).to have_content('The 5G technology is a master piece')
        expect(page).to have_content('European football clubs are very good')
        expect(page).to have_content('Python is a cool language with english syntax')
      end

      it 'should show how many comments a post has.' do
        visit user_posts_path(@user.id)
        expect(page).to have_content('Comments 2')
        expect(page).to have_content('Comments 2')
        expect(page).to have_content('Comments 2')
      end

      it 'should show how many likes a post has.' do
        visit user_posts_path(@user.id)
        expect(page).to have_content('Likes 1')
      end

      it 'should redirect to post show page when clicked' do
        visit user_posts_path(@user.id)
        click_link 'Technology'
        expect(page).to have_current_path user_post_path(@user.id, @post_first.id)
      end
    end

    # Test block for post show page
    describe 'show page' do
      it 'should show who wrote the post.' do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('Raymond')
      end

      it "should show the post's title." do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('Technology')
      end

      it 'should show the post body.' do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('Latest technological trends')
      end

      it 'should show how many comments a post has.' do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('Comments: 2')
      end

      it 'should show how many likes it has.' do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('Likes: 1')
      end

      it 'should show the username of each commentor.' do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('Raymond')
      end

      it 'should show the comment each commentor left.' do
        visit user_post_path(@user.id, @post_first.id)
        expect(page).to have_content('I admire latest technological innovations')
      end
    end
  end
end
