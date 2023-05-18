require 'rails_helper'

describe 'Post index page', type: :feature do
  before :each do
    @user = User.create(name: 'Fitz Gerald', photo: 'https://via.placeholder.com/150', bio: 'I am Fitz Gerald')
    @post = Post.create(author_id: @user.id, title: 'the black cat',
                        text: 'this novel is about an antique inspector that ')
    @post_one = Post.create(author_id: @user.id, title: 'twilighted novel', text: 'this novel is about Vampires')
    @post_two = Post.create(author_id: @user.id, title: 'the lord of the rings', text: 'this novel is about a hobbit')
    @post_three = Post.create(author_id: @user.id, title: 'the hobbit', text: 'the hobbit of tobias')
    @post_four = Post.create(author_id: @user.id, title: 'goosebump', text: 'this novel is a series of horro stories')
    @post_five = Post.create(author_id: @user.id, title: 'fleur',
                             text: 'this novel about a girl who got married to a blinf man')
    @post_six = Post.create(author_id: @user.id, title: 'the old and the sea',
                            text: 'about the struggle of an old man and the sea')
    @comment = Comment.create(post: @post, author: @user, text: 'the black cat is a great book')
    @comment_one = Comment.create(post: @post_one, author: @user, text: 'twilight is a great book')
  end

  it 'shows the user profile picture' do
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'shows the username of the user' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts for the user' do
    expect(page).to have_content(@user.posts_counter)
  end

  it 'shows the title of posts' do
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post_four.title)
  end

  it 'shows some of the posts text' do
    expect(page).to have_content(@post_two.text)
    expect(page).to have_content(@post_three.text)
  end

  it 'shows the first comments of a post' do
    expect(page).to have_content(@comment.text)
    expect(page).to have_content(@comment_two.text)
  end

  it 'shows the number of comments and likes for each post' do
    expect(page).to have_content(@post.comments_counter)
    expect(page).to have_content(@post_four.comments_counter)
    expect(page).to have_content(@post_two.likes_counter)
    expect(page).to have_content(@post_three.likes_counter)
  end

  it 'has no pagination for five posts or less' do
    expect(page).not_to have_selector('nav.pagination')
  end

  it 'redirects to post show page of a clicked post' do
    click_link @post.title
    expect(page).to have_current_path(user_post_path(@user, @post))
  end

  it 'redirects to post show page of a clicked post' do
    click_link @post_two.title
    expect(page).to have_current_path(user_post_path(@user, @post_two))
  end

  context 'when there are more than 5 posts' do
    before :each do
      @post_six = Post.create(author: @user, title: 'Resurrection', text: 'I am the One')
      visit user_posts_path(@user)
    end
    it 'has pagination' do
      expect(page).to have_button('Pagination')
    end
  end
end
