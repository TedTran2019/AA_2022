require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_selector :button, 'Create New User'
  end
  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: 'username'
      fill_in 'Password', with: 'password'
      click_on 'Create New User'
    end
    scenario 'shows username on the homepage after signup' do
      visit users_url
      expect(page).to have_content('username').twice
    end
  end
end

feature 'logging in' do
  before(:each) do
    User.create!(username: 'username', password: 'password')
    visit new_session_url 
    fill_in 'Username', with: 'username'
    fill_in 'Password', with: 'password'
    click_on 'Login!'
  end

  scenario 'shows username on the homepage after login' do
    visit users_url
    expect(page).to have_content('username').twice
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to have_selector :link, 'New User'
  end
  scenario 'doesn\'t show username on the homepage after logout' do
    User.create!(username: 'username', password: 'password')
    visit users_url
    expect(page).to have_content('username')
  end

end