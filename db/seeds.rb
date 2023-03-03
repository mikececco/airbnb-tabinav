# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

puts "Clearing database..."
Review.destroy_all
Booking.destroy_all
Flat.destroy_all
User.destroy_all


jeroen = User.create!(email: "jeroen@tabinav.com", password: "111111", first_name: "Jeroen", last_name: "Hesp", phone_number: "123456789")
mike = User.create!(email: "mike@tabinav.com", password: "111111", first_name: "Mike", last_name: "Cecconello", phone_number: "123456789")
ronnie = User.create!(email: "ronnie@tabinav.com", password: "111111", first_name: "Ronnie", last_name: "Hernaman", phone_number: "123456789")
eirene = User.create!(email: "eirene@tabinav.com", password: "111111", first_name: "Eirene", last_name: "Chan", phone_number: "123456789")
admin = User.create!(email: "admin@tabinav.com", password: "111111", first_name: "Tabinav", last_name: "Tabinav")

puts "Accounts for Jeroen, Mike, Ronnie, Eirene were created! \nEmail: jeroen@tabinav.com | mike@tabinav.com | ronnie@tabinav.com | eirene@tabinav.com \nPassword: 111111"
puts "---\n"
puts "Creating 20 flats in NL..."

nl_addresses = {
  "Amsterdam" => ["537 Pinasstraat", "572 Kloekhorststraat", "IJsbaanpad 9", "18, Erik de Roodestraat", "5C, Vincent van Gogh Street", "4, Koningin Wilhelminaplein", "371, Prinseneiland", "23, Pennyhof", "29, M.C. Addicksstraat", "207, Van der Palmkade"],
  "Rotterdam" => ["31, Jean Sibeliusstraat", "6, Mesdaglaan", "Galvanaistraat", "364, Plaszoom", "125, Tinbergenlaan"],
  "Utrecht" => ["Mozartlaan 29", "Nieuwegracht", "Maliesingel 9-6", "Lamérislaan 33-55", "R.A. Kartinistraat"],
}

nl_addresses.each do |city, array|
  array.each do |street|
    puts "--#{street}"
    puts "--image start upload"
    file = URI.open("https://source.unsplash.com/random/1200x800/?#{city}")
    puts "--image uploaded"
    price = rand(39..99)
    description = "Bumble Barn has a large sitting, dining and kitchen area, opening onto the patio with views of the horse paddocks, open field and trees.
    Sitting Room has a smart 4K TV.
    Fully equipped kitchen with large fridge/freezer.
    Main bedroom with king sized double bed and en suite shower room. Optional colour changing LED lighting.
    2 twin bedrooms. Main bathroom with bath/shower\n\n
    It combines perfectly the authenticity of its architecture with the modernity of its decoration and amenities. It offers 600 square meters of internal spaces to be able to live for a few days with your family, your friends or your colleagues there."
    flat = Flat.new(address: street, city: city, flat_location: "NL", price: price, user: [admin, eirene, ronnie, jeroen].sample , description: description)
    flat.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
    flat.save!
  end
end

puts "20 flats in NL created!"
puts "---\n"
puts "Creating Mike's flats..."

mike_flats = ["Roggekamp 90", "Dwingelostraat", "Heliotrooplaan 38", "Haviklaan 20", "Walenburg 6"]
mike_flats.each do |street|
  puts "--#{street}"
  puts "--image start upload"
  file = URI.open("https://source.unsplash.com/random/1200x800/?the-hague")
  puts "--image uploaded"
  price = rand(39..99)
  description = "Bumble Barn has a large sitting, dining and kitchen area, opening onto the patio with views of the horse paddocks, open field and trees.
  Sitting Room has a smart 4K TV.
  Fully equipped kitchen with large fridge/freezer.
  Main bedroom with king sized double bed and en suite shower room. Optional colour changing LED lighting.
  2 twin bedrooms. Main bathroom with bath/shower\n\n
  It combines perfectly the authenticity of its architecture with the modernity of its decoration and amenities. It offers 600 square meters of internal spaces to be able to live for a few days with your family, your friends or your colleagues there."
  flat = Flat.new(address: street, city: "The Hague", flat_location: "NL", price: price, user: mike, description: description)
  flat.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  flat.save!
end

puts "Mike's flats created!"
puts "---\n"
puts "Booking Mike's flats"

5.times do
  start_date = Date.today + (rand(4..20) * 10)
  duration = rand(3..10)
  end_date = start_date + duration
  booking = Booking.new(start_date: start_date, end_date: end_date, user: [eirene, ronnie, jeroen].sample)
  booking.flat = mike.flats.sample
  booking.save!
end

puts "5 bookings on Mike's flats"
puts "---\n"
puts "Mike booking flats..."

def book_flats(city, user, start_date)
  flat = Flat.where(city: city).sample
  flat_owner = flat.user
  duration = rand(3..10)
  end_date = start_date + duration
  booking = Booking.new(start_date: start_date, end_date: end_date, user: user, flat: flat)
  booking.save!
end

book_flats("Rotterdam", mike, Date.today + 40)
book_flats("Utrecht", mike, Date.today + 100)

puts "Mike booked 2 flats"
