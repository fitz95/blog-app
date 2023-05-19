# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

first_post = Post.create(user: first_user, title: 'Hello', text: 'This is my first post')

Comment.create(post: first_post, user: second_user, text: 'Hi Tom!')

first_user.all.each do |user|
    5.times do |i|
        Post.create(user: first_user, title: "Post #{i}", text: "This is post #{i} from #{first_user.name}")
    end
end

second_user.all.each do |user|
    5.times do |i|
        Post.create(user: second_user, title: "Post #{i}", text: "This is post #{i} from #{second_user.name}")
    end
end

User.all.each do |user|
    user.update(password: 'password@123')
end

5.times do
    User.create(
      name: Faker::Name.name,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.paragraph,
      email: Faker::Internet.email
    )
  end