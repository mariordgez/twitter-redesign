require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'index page' do
    it 'shows the right content' do
      visit root_path

      expect(page).to have_content('Log in')
    end
  end
  describe 'the signin process', type: :feature do
    before :each do
      User.create(
        email: 'user1@example.com',
        password: 'password',
        name: 'user1',
        username: 'usea1'
      )

      User.create(
        email: 'user2@example.com',
        password: 'password',
        name: 'user2',
        username: 'usea2'
      )

      User.create(
        email: 'user3@example.com',
        password: 'password',
        name: 'user3',
        username: 'usea3'
      )
    end

    it 'signs me in' do
      visit user_session_path

      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
  describe 'Create a tweet process', type: :feature do
    before :each do
      User.create(
        id:1,
        email: 'user1@example.com',
        password: 'password',
        name: 'user1',
        username: 'usea1'
      )

      User.create(
        id:2,

        email: 'user2@example.com',
        password: 'password',
        name: 'user2',
        username: 'usea2'
      )

      User.create(
        id:3,
        email: 'user3@example.com',
        password: 'password',
        name: 'user3',
        username: 'usea3'
      )
    end

    it 'successfully creates a new tweet' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      expect(page).to have_content 'Tweet was successfully created.'
    end
    it 'redirects to sign in page since you need to be signed in' do
      visit user_session_path
      click_link('new-post')
      expect(
        page
      ).to have_content 'You need to sign in or sign up before continuing.'
    end

    it 'Should not have the tweet displayed since another user is signed in' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      click_link('sign-out')
      fill_in 'user_email', with: 'user2@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      click_link('Profile')

      expect(page).to_not have_content 'this is a new tweet'
    end
    it 'Should display number of tweets created' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet 5'
      click_button 'Create Tweet'
      click_link('Profile')
      
      expect(page).to have_content 2
    end
  end

  describe 'Search feature', type: :feature do
    before :each do
      User.create(
        id:1,
        email: 'user1@example.com',
        password: 'password',
        name: 'user1',
        username: 'usea1'
      )

      User.create(
        id:2,

        email: 'user2@example.com',
        password: 'password',
        name: 'user2',
        username: 'usea2'
      )

      User.create(
        id:3,
        email: 'user3@example.com',
        password: 'password',
        name: 'user3',
        username: 'usea3'
      )
    end

    it 'successfully searches for a user' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Find a user', with: 'user3'
      click_button 'Search'
      expect(page).to have_content 'user3'
    end

    it 'successfully finds two users with similar names' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Find a user', with: 'user'
      click_button 'Search'
      expect(page).to have_content 'user2'
      expect(page).to have_content 'user3'
    end

    it 'should not have user2 on the search results' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Find a user', with: 'user3'
      click_button 'Search'
      expect(page).to_not have_content 'user2'
   
    end
  
  end
  describe 'Followings', type: :feature do
    before :each do
      User.create(
        email: 'user1@example.com',
        password: 'password',
        name: 'user1',
        username: 'usea1'
      )

      User.create(
        email: 'user2@example.com',
        password: 'password',
        name: 'user2',
        username: 'usea2'
      )

      User.create(
        email: 'user3@example.com',
        password: 'password',
        name: 'user3',
        username: 'usea3'
      )
    end

    it 'successfully creates a new follow' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      first(:link, 'Follow').click
      expect(page).to have_content 'You added a new person to your following list'
    end
    it 'Displays number of followers' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      first(:link, 'Follow').click
      click_link('sign-out')
      fill_in 'user_email', with: 'user2@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'

      expect(page).to have_content '1'
    end
   
    it 'Displays number of followings' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      first(:link, 'Follow').click

      expect(page).to have_content '1'
    end
    it 'Allows you to unfollow someone' do
      visit user_session_path
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      fill_in 'Compose a new tweet...', with: 'this is a new tweet'
      click_button 'Create Tweet'
      first(:link, 'Follow').click
      click_link('Unfollow')

      expect(page).to have_content 'Your follow was successfully removed'
    end
  end
end
