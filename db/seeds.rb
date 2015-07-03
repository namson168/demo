# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Bui Quoc Dat",
             email: "dat@test.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)

end

users = User.order(:created_at).take(6)
30.times do
  title = Faker::Lorem.sentence(2)
  body = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(title: title, body: body) }
end

# Following relationships
#users = User.all
#user  = users.first
#following = users[2..50]
#followers = users[3..40]
#following.each { |followed| user.follow(followed) }
#followers.each { |follower| follower.follow(user) }


entries = Entry.order(:created_at).take(6)
users_id = 1
8.times do
  content = Faker::Lorem.sentence(5)
  entries.each { |entries| entries.comments.create!(user_id: users_id, content: content) }
end