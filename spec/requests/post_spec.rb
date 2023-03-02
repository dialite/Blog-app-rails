require 'rails_helper'

RSpec.describe 'PostsController', type: %w[request feature] do
  let!(:user) do
    User.create(
      name: 'Raymond',
      photo: 'https://thekingchioce.game.jpg',
      bio: 'I am the King',
      posts_counter: 0
    )
  end

  describe 'GET /users/:user_id/posts' do
    before { get "/users/#{user.id}/posts" }

    it 'responds with a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'returns http success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('List of Users Posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    let!(:post) do
      Post.create(
        title: 'Career Path',
        text: 'Software Programmer',
        author_id: user.id,
        comments_counter: 2,
        likes_counter: 2
      )

      before { get "/users/#{user.id}/posts/#{post.id}" }

      it 'responds with a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'displays the correct text' do
        expect(response.body).to include('Single Post View')
      end
    end
  end
end
