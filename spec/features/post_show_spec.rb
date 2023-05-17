require 'rails_helper'

describe 'Post show page', type: :feature do
  before :each do
    @user = User.create(name: 'Fitz Gerald', photo: 'https://via.placeholder.com/150', bio: 'I am Fitz Gerald')
    @post = Post.create(author_id: @user.id, title: 'the black cat', text: 'this novel is about an antique inspector that does his best to recover stolen artefacts')
    @comment = Comment.create(post: @post, author:@user, text: 'the black cat is a great book')
    visit user_post_path(@user, @post)
  end
  it 'shows the title of the post' do
    expect(page).to have_content(@post.title)
  end

  it 'shows the author of the post' do
    expect(page).to have_content(@post.author.name)
  end

  it 'shows the number of comments and likes for the post' do
    expect(page).to have_content(@post.commentscounter)
    expect(page).to have_content(@post.likescounter)
  end

  it 'shows the body of the post' do
    expect(page).to have_content(@post.text)
  end

  it 'shows the username of a commenter and their comment' do
    expect(page).to have_content(@comment.author.name)
    expect(page).to have_content(@comment.text)
  end
end