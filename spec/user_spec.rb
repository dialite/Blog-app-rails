require_relative './rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(
      name: 'Raymond',
      bio: 'Software Programmer',
      photo: 'http://myviews.com/org.jpg',
      posts_counter: 1
    )
  end

  it '@user as created is valid' do
    expect(@user).to be_valid
  end

  it 'name should be Raymond' do
    expect(@user.name).to eql 'Raymond'
  end

  it 'name should be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'photo should be valid' do
    expect(@user.photo).to eql 'http://myviews.com/org.jpg'
  end

  it 'bio should be valid' do
    expect(@user.bio).to eql 'Software Programmer'
  end

  it 'posts counter should be valid' do
    expect(@user.posts_counter).to eql 1
  end

  it 'posts counter should be present' do
    @user.posts_counter = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be >= 0' do
    @user.posts_counter = -5
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be numeric' do
    @user.posts_counter = 'One'
    expect(@user).to_not be_valid
  end

  it 'should return a users last 3 posts' do
    user = User.create(
      name: 'Raymond',
      bio: 'Software Programmer',
      photo: 'http://myviews.com/org.jpg',
      posts_counter: 0
    )
    10.times.collect do
      Post.create(
        title: 'The Election',
        text: 'Ensure you vote democratically',
        author_id: user.id,
        likes_counter: 0,
        comments_counter: 0
      )
    end
    expect(user.recent_posts.length).to eq(3)
  end
end
