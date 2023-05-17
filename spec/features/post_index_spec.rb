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

  context 'five posts or less' do
    visit users_posts_path(@user)
    it 'shows post information' do
      expect(page).to have_content(@user.name)
      expect(page).to have_css("img[src='#{@user.photo}']")
      expect(page).to have_content(@user.postscounter)
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@post_two.text)
      expect(page).to have_content(@post_three.text)
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@comment_one.text)
      expect(page).to have_content(@post.commentscounter)
      expect(page).to have_content(@post_four.commentscounter)
      expect(page).to have_content(@post_two.likescounter)
      expect(page).to have_content(@post_three.likescounter)
    end
  end

  context 'more than five posts' do
    before :each do
      @post_six = Post.create(author: @user, title: 'New Adventures', text: 'Exploring the Matrix')
      @post_seven = Post.create(author: @user, title: 'Chasing Agents', text: 'Escape at all costs')
      @post_eight = Post.create(author: @user, title: 'The Prophecy', text: 'Fulfilling my destiny')
      @post_nine = Post.create(author: @user, title: 'The Final Battle', text: 'Saving humanity')
      visit user_posts_path(@user)
    end

    it 'shows only the latest five posts' do
      expect(page).not_to have_content(@post_two.text)
      expect(page).not_to have_content(@post_three.text)
      expect(page).not_to have_content(@post_four.title)
      expect(page).to have_content(@post_five.title)
      expect(page).to have_content(@post_six.title)
      expect(page).to have_content(@post_seven.text)
      expect(page).to have_content(@post_eight.text)
      expect(page).to have_content(@post_nine.title)
    end
  end
end
