require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }
  scenario 'Page should have username of other users' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now)
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now)
    @user3 = User.create(name: 'Manny', email: 'manny@gmail.com', password: 'qwerty', confirmed_at: Time.now)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
      expect(page).to have_content 'Titus'
      expect(page).to have_content 'Julie'
      expect(page).to have_content 'Manny'
  end

  scenario 'Page should have profile photo for each user' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg')
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
      expect(find('img') { |img| img[:src] == "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg" }).to be_truthy
  end

  scenario 'Should see number of post for each user' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now)
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now)

    Post.create(title: "Lorem ipsum dolor sit amet", text: "Etiam et mauris et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
      expect(page).to have_content "Number of posts: #{@user1.posts.size}"
      expect(page).to have_content "Number of posts: #{1}"
  end

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now)
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now)

    Post.create(title: "Lorem ipsum dolor sit amet", text: "Etiam et mauris et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to have_content "Etiam et mauris et ligula"
  end
end