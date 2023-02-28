# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating users..."

User.create!(email: "jeroen@tabinav.com", password: "111111", first_name: "Jeroen", last_name: "Hesp", phone_number: "123456789")
User.create!(email: "mike@tabinav.com", password: "111111", first_name: "Mike", last_name: "Cecconello", phone_number: "123456789")
User.create!(email: "ronnie@tabinav.com", password: "111111", first_name: "Ronnie", last_name: "Hernaman", phone_number: "123456789")
User.create!(email: "eirene@tabinav.com", password: "111111", first_name: "Eirene", last_name: "Chan", phone_number: "123456789")
admin = User.create!(email: "admin@tabinav.com", password: "111111", first_name: "Tabinav", last_name: "Tabinav")

puts "Accounts for Jeroen, Mike, Ronnie, Eirene were created! \nEmail: jeroen@tabinav.com | mike@tabinav.com | ronnie@tabinav.com | eirene@tabinav.com \nPassword: 111111"
puts "---\n"

puts "Creating 10 flats..."

10.times do
  Flat.create!(address: Faker::Address.street_address, city: Faker::Address.city, flat_location: Faker::Address.country, price: rand(59..109), user: admin)
end

puts "10 flats created!"
