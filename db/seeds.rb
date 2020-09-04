50.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  image = "image"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               image: image,
               )
end
