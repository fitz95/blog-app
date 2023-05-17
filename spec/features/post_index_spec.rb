require 'rails_helper'

describe 'Post index page', type: :feature do
    before :each do
        @user = User.create(name: 'Fitz Gerald', photo: 'https://via.placeholder.com/150', bio: 'I am Fitz Gerald')
        @post = Post.create(author_id: @user.id, title: 'the black cat', text: 'this novel is about an antique inspector that ')
        @post_1 = Post.create(author_id: @user.id, title: 'twilighted novel', text: 'this novel is about Vampires')
        @post_2= Post.create(author_id: @user.id, title: 'the lord of the rings', text: 'this novel is about a hobbit')
        @post_3= Post.create(author_id: @user.id, title: 'the hobbit', text: 'the hobbit of tobias')
        @post_4 = Post.create(author_id: @user.id, title: 'goosebump', text: 'this novel is a series of horro stories')
        @post_5 = Post.create(author_id: @user.id, title: 'fleur', text: 'this novel about a girl who got married to a blinf man')
        @post_6 = Post.create(author_id: @user.id, title: 'the old and the sea', text: 'about the struggle of an old man and the sea')
        @comment = Comment.create(post: @post, author:@user, text: 'the black cat is a great book')
        @comment_1 = Comment.create(post: @post_1, author:@user, text: 'twilight is a great book')
        visit user_posts_path(@user)
    end

    context 'five posts or less' do 
        it 'shows post information' do
            expect(page).to have_content(@user.name)
            expect(page).to have_css("img[src='#{@user.photo}']")
            expect(page).to have_content(@user.postscounter)
            expect(page).to have_content(@post.title)
            expect(page).to have_content(@post_2.text)
            expect(page).to have_content(@post_3.text)
            expect(page).to have_content(@comment.text)
            expect(page).to have_content(@comment_1.text)
            expect(page).to have_content(@post.commentscounter)
            expect(page).to have_content(@post_4.commentscounter)
            expect(page).to have_content(@post_2.likescounter)
            expect(page).to have_content(@post_3.likescounter)
        end
    end

    context 'more than five posts' do
        before :each do
            @post_6 = Post.create(author: @user, title: 'New Adventures', text: 'Exploring the Matrix')
            @post_7 = Post.create(author: @user, title: 'Chasing Agents', text: 'Escape at all costs')
            @post_8 = Post.create(author: @user, title: 'The Prophecy', text: 'Fulfilling my destiny')
            @post_9 = Post.create(author: @user, title: 'The Final Battle', text: 'Saving humanity')
            visit user_posts_path(@user)
        end

        it 'shows only the latest five posts' do
            expect(page).not_to have_content(@post_2.text)
            expect(page).not_to have_content(@post_3.text)
            expect(page).not_to have_content(@post_4.title)
            expect(page).to have_content(@post_5.title)
            expect(page).to have_content(@post_6.title)
            expect(page).to have_content(@post_7.text)
            expect(page).to have_content(@post_8.text)
            expect(page).to have_content(@post_9.title)
        end
    end

end