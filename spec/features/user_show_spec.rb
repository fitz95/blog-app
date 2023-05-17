require 'rails_helper'

describe 'User show page', type: :feature do
    before :each do
        @user = User.create(name: 'Fitz Gerald', photo: 'https://via.placeholder.com/150', bio: 'I am Fitz Gerald')
        @post = Post.create(author_id: @user.id, title: 'the black cat', text: 'this novel is about an antique inspector that does his best to recover stolen artefacts')
        @post_1 = Post.create(author_id: @user.id, title: 'twilight ', text: 'this novel is about Vampires')
        @post_2= Post.create(author_id: @user.id, title: 'the lord of the rings', text: 'This novel is about a hobbit that has to destroy a ring')
        @post_3= Post.create(author_id: @user.id, title: 'the hobbit', text: 'this novel is about a hobbit that has to destroy a ring')
        @post_4 = Post.create(author_id: @user.id, title: 'goosebump', text: 'this novel is a series of horro stories')
        visit user_posts_path(@user, @posts)
    end

    it 'shows user info' do
        expect(page).to have_content(@user.name)
        expect(page).to have_css("img[src='#{@user.photo}']")
        expect(page).to have_content(@user.postscounter)
        expect(page).to have_content(@user.bio)
        expect(page).to have_content(@post_2.title)
        expect(page).to have_content(@post_3.title)
        expect(page).to have_content(@post_4.title)
        expect(page).to have_button('See all posts')
    end

    it 'redirects to post page' do
        click_link @post_2.title
        expect(page).to have_current_path(user_post_path(@user, @post_2))
    end

    it 'redirects to post_2 page' do
        click_link @post_3.title
        expect(page).to have_current_path(user_post_path(@user, @post_3))
    end

    it 'redirects to all posts page' do
        click_link 'See all posts'
        expect(page).to have_current_path(user_posts_path(@user))
    end
end