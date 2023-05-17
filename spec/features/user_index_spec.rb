require 'rails_helper'


describe 'User index page', type: :feature do
  before :each do
    @user = User.create(name: 'Neo', photo: 'neo.jpg', bio: 'The One')
    @user_2 = User.create(name: 'Morpheus', photo: 'morpheus.jpg', bio: 'The Captain')
    visit root_path
  end

  context 'describe user indexe users' do

    it 'shows users  profile picture' do
      puts page.html
      expect(page).to have_css("img[src='neo.jpg']") 
      expect(page).to have_css("img[src='morpheus.jpg']")
    end

    it 'shows username for all users' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user_2.name)
    end

    it 'shows number of post' do 
      expect(page).to have_content(@user.postscounter)
      expect(page).to have_content(@user_2.postscounter)
    end

    it 'redirects to user page' do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user))
    end
  end
end