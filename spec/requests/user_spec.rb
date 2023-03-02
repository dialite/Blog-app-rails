require 'rails_helper'

RSpec.describe 'Users', type: %w[request feature] do
  let!(:user) do
    User.create(
      name: 'Raymond',
      bio: 'Software Programmer',
      photo: 'https://thekingchioce.game.jpg',
      posts_counter: 0
    )
  end

  describe 'GET #index' do
    before { get '/users/' }

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('List of all Users')
    end
  end

  describe 'GET #show' do
    before { get "/users/#{user.id}" }

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('User Profile')
    end
  end
end