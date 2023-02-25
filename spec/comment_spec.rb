require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Raymond',
      photo: 'https://thekingchioce.game.jpg',
      bio: 'I am the King',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'Career Path',
      text: 'Software Programmer',
      author_id: @user.id,
      comments_counter: 1,
      likes_counter: 0
    )
  end

  object { Comment.new(text: 'Hi', author: @user, post: @post) }

  it 'Comments counter should be 1' do
    expect(@post.comments_counter).to eq 1
  end

  it 'should not be valid without a post' do
    object.post = nil
    expect(object).to_not be_valid
  end

  it 'should not be valid without an author' do
    object.author = nil
    expect(object).to_not be_valid
  end
end