# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

puts "Clearing database..."
User.destroy_all
Flat.destroy_all

User.create!(email: "jeroen@tabinav.com", password: "111111", first_name: "Jeroen", last_name: "Hesp", phone_number: "123456789")
User.create!(email: "mike@tabinav.com", password: "111111", first_name: "Mike", last_name: "Cecconello", phone_number: "123456789")
User.create!(email: "ronnie@tabinav.com", password: "111111", first_name: "Ronnie", last_name: "Hernaman", phone_number: "123456789")
eirene = User.create!(email: "eirene@tabinav.com", password: "111111", first_name: "Eirene", last_name: "Chan", phone_number: "123456789")
admin = User.create!(email: "admin@tabinav.com", password: "111111", first_name: "Tabinav", last_name: "Tabinav")

puts "Accounts for Jeroen, Mike, Ronnie, Eirene were created! \nEmail: jeroen@tabinav.com | mike@tabinav.com | ronnie@tabinav.com | eirene@tabinav.com \nPassword: 111111"
puts "---\n"
puts "Creating 10 flats..."

10.times do
  address = Faker::Address.street_address
  city = Faker::Address.city
  country = Faker::Address.country
  file = URI.open("https://source.unsplash.com/random/600x400/?#{city}")
  price = rand(39..109)
  flat = Flat.new(address: address, city: city, flat_location: country, price: price, user: admin)
  flat.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  flat.save!

  start_date = Date.today
  duration = rand(3..7)
  end_date = start_date + duration
  booking = Booking.new(start_date: start_date, end_date: end_date, user: eirene)
  booking.flat = flat
  booking.save!
end

puts "10 flats created with 1 booking for each flat!"
