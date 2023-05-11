require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'Anything',
                  photo: 'http://licalhost:3000/anything.jpg',
                  bio: 'Anything test',
                  postscounter: 0)
  post = Post.new(
    title: 'Anything',
    text: 'Anything test',
    author: user,
    commentscounter: 0,
    likescounter: 0
  )
  subject do
    described_class.new(
      author: user,
      post:
    )
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
