# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin_bot = User.create!(id: 0, first_name: "BuiltBetter", last_name: "Bot", phone_number: "(000)000-0000", email: "builtbetter@info.com", job_title: "Helper Bot", password: "password", admin: "true", profile_image: "https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&radius=50&scale=70&shapeColor=000000&backgroundColor=D2042D")
admin_bot.save!

puts 'Default admin user created'
