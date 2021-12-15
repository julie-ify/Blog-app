require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg")

    Post.create(title: "Lorem ipsum dolor sit amet", text: "Etiam et mauris et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(find('img') { |img| img[:src] == "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg" }).to be_truthy
  end

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg")

    Post.create(title: "Lorem ipsum dolor sit amet", text: "Etiam et mauris et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to have_content "Julie"
  end

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg")

    Post.create(title: "Lorem ipsum dolor sit amet", text: "Etiam et mauris et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to have_content "Number of posts: #{1}"
  end

  scenario "can see the user's bio." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "Software engineer")

    Post.create(title: "Lorem ipsum dolor sit amet", text: "Etiam et mauris et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to have_content @user2.bio
  end

  scenario "can see the user's first 3 posts." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "Software engineer")

    Post.create(title: "hello there", text: "Etiam et mauris et", author_id: @user2.id)
    Post.create(title: "ipsum dolor sit amet", text: "et mauris et ligula", author_id: @user2.id)
    Post.create(title: "sum dolor sit amet", text: "Etiam et et ligula", author_id: @user2.id)
    Post.create(title: "anything", text: "iam et et ligula", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to_not have_content "hello there"
  end

  scenario "can see a button that lets me view all of a user's posts." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "Software engineer")

    Post.create(title: "Lorem ipsum dolor", text: "Etiam et mauris et", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page.has_link?('See all posts')).to be true
  end

  scenario "can see a button that lets me view all of a user's posts." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "Software engineer")

    @post = Post.create(title: "Lorem ipsum dolor", text: "Etiam et mauris et", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page.has_button?('Add Comment')).to be true
  end

  scenario "can see a button that lets me view all of a user's posts." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now, photo: "http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg", bio: "Software engineer")

    @post = Post.create(title: "Lorem ipsum dolor", text: "Etiam et mauris et", author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page.has_button?('Pagination')).to be true
  end
end