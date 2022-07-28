# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all
User.destroy_all

PASSWORD = "123"
super_user = User.create(
  name: "Admin User",
  email: "admin@user.com",
  password: PASSWORD,
  admin: true
)

10.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    name: first_name + " " + last_name,
    email: "#{first_name}@#{last_name}.com",
    password: PASSWORD
  )
end

users = User.all

50.times do
    p = Post.create(
        title: Faker::FunnyName.name,
        body: Faker::Lorem.sentence(word_count: 50),
        user: users.sample
    )
end

posts = Post.all