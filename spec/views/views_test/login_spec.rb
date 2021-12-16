require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }
  scenario 'Page should have a login form' do
    expect(page.has_field?('Email')).to be true
    expect(page.has_field?('Password')).to be true
    expect(page.has_button?('Log in')).to be true
  end

  context 'Form Submission' do
    scenario 'Submit form without email and password' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'Submit form with incorrect email and password' do
      within 'form' do
        fill_in 'Email', with: 'hello@gmail.com'
        fill_in 'Password', with: '222222'
      end
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'Submit form with correct email and password' do
      @user = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now)
      within 'form' do
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
      end
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
