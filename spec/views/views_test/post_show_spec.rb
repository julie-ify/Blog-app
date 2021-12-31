require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Index', type: :feature do
  background { visit new_user_session_path }

  scenario "I can see the post's title." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image',
                         bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @post.title
  end

  scenario 'I can see who wrote the post.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @user2.name
  end

  scenario 'I can see how many comments it has.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    @coment = Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                             post_id: @post.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content "Comments : #{@post.comments.size}"
  end

  scenario 'I can see how many likes it has.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content 'Likes : 1'
  end

  scenario 'I can see the post body.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @post.text
  end

  scenario 'I can see the username of each commentor.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    @coment1 = Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' second comment', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' third comment', author_id: @user1.id, post_id: @post.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @user1.name
    expect(page).to have_content @user2.name
  end

  scenario 'I can see the comment each commentor left.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    @coment1 = Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' second comment', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' third comment', author_id: @user1.id, post_id: @post.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @coment1.text
    expect(page).to have_content @coment2.text
  end
  # rubocop:enable Metrics/BlockLength
end
