module UsersHelper
  def user_img(user)
    user.photo.present? ? user.photo : '../assets/images/frame.png'
  end
end
