require 'rails_helper'

RSpec.describe Like, type: :model do
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
      comments_counter: 2,
      likes_counter: 2
    )
  end

  subject { Like.new(author: @user, post: @post) }

  it 'likes counter should be 2' do
    expect(@post.likes_counter).to eq 2
  end

  it 'should not be valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end
end
