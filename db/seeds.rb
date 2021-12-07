# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

6.times do |num|
  user = User.create(
    name: "user#{num + 1}",
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis eros ut diam tempus semper. Praesent porta ut justo nec pharetra. Etiam maximus, diam in varius condimentum, metus nisi suscipit augue, at volutpat tortor urna vitae elit. Etiam quis turpis nec neque dignissim tempor. Sed tempor turpis elit, non pulvinar ante tincidunt eget. Pellentesque et aliquam est, quis accumsan ligula. Suspendisse nec dui felis."
  )

    4.times do |num|
    post = Post.create(
      title: "post#{num + 1}",
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis eros ut diam tempus semper. Praesent porta ut justo nec pharetra. Etiam maximus, diam in varius condimentum, metus nisi suscipit augue, at volutpat tortor urna vitae elit. Etiam quis turpis nec neque dignissim tempor. Sed tempor turpis elit, non pulvinar ante tincidunt eget. Pellentesque et aliquam est, quis accumsan ligula. Suspendisse nec dui felis. Proin aliquet tristique neque, nec mollis libero semper ut. Vivamus a interdum leo, ut elementum lectus. Proin a pharetra diam. Suspendisse a efficitur nibh. Donec posuere ligula sed felis accumsan vulputate.",
      author: user
    )

      3.times do |num|
        Comment.create(
          text: "This is comment#{num + 1}",
          author: user,
          post: post
        )
      end
    end
end

