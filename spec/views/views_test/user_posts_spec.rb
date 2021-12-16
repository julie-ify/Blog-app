require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Index', type: :feature do
  background { visit new_user_session_path }
  scenario "I can see the user's profile picture." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(find('img') do |img|
             img[:src] == 'http/url/image'
           end).to be_truthy
  end

  scenario "I can see the user's username." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Julie'
  end

  scenario 'I can see the number of posts the user has written' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content "Number of posts: #{@user2.posts.size}"
  end

  scenario " can see a post's title." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'hello there'
  end

  scenario " can see some of the post's body." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Etiam et mauri'
  end

  scenario 'can see the first comments on a post.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'consectetur adipiscing'
  end

  scenario 'I can see how many comments a post has.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    @coment1 = Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' second comment', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Comments: 3'
  end

  scenario ' can see how many likes a post has.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Likes: 1'
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    @coment1 = Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' second comment', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)
    @coment33 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)
    @coment32 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page.has_button?('Pagination')).to be true
  end

  scenario "When I click on a post, it redirects me to that post's show page." do
    @user1 = User.create(name: 'Titus', email: 'titus@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: "I'm a good person")
    @user2 = User.create(name: 'Julie', email: 'julie@gmail.com', password: 'qwerty', confirmed_at: Time.now,
                         photo: 'http/url/image', bio: 'Software engineer')

    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user2.id)
    @coment1 = Comment.create(text: ' consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' second comment', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)
    @coment33 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)
    @coment32 = Comment.create(text: ' third comment', author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page.has_button?('Add Comment')).to be true
    expect(page.has_button?('Like this post')).to be true
  end
  # rubocop:enable Metrics/BlockLength
end
