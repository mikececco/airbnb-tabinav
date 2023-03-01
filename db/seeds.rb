# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

puts "Clearing database..."
Booking.destroy_all
Flat.destroy_all
User.destroy_all


User.create!(email: "jeroen@tabinav.com", password: "111111", first_name: "Jeroen", last_name: "Hesp", phone_number: "123456789")
User.create!(email: "mike@tabinav.com", password: "111111", first_name: "Mike", last_name: "Cecconello", phone_number: "123456789")
User.create!(email: "ronnie@tabinav.com", password: "111111", first_name: "Ronnie", last_name: "Hernaman", phone_number: "123456789")
eirene = User.create!(email: "eirene@tabinav.com", password: "111111", first_name: "Eirene", last_name: "Chan", phone_number: "123456789")
admin = User.create!(email: "admin@tabinav.com", password: "111111", first_name: "Tabinav", last_name: "Tabinav")

puts "Accounts for Jeroen, Mike, Ronnie, Eirene were created! \nEmail: jeroen@tabinav.com | mike@tabinav.com | ronnie@tabinav.com | eirene@tabinav.com \nPassword: 111111"
puts "---\n"
puts "Creating 30 flats in NL..."

nl_addresses = {
  "Amsterdam" => ["537 Pinasstraat", "572 Kloekhorststraat", "IJsbaanpad 9", "18, Erik de Roodestraat", "5C, Vincent van Gogh Street", "4, Koningin Wilhelminaplein", "371, Prinseneiland", "23, Pennyhof", "29, M.C. Addicksstraat", "207, Van der Palmkade"],
  "Rotterdam" => ["12, Keilezijweg", "131, Bunschotenweg", "60A, Westerbeekstraat", "39, Charlie Shaverslaan", "31, Jean Sibeliusstraat", "6, Mesdaglaan", "48A, Burgemeester Hoffmanplein", "Galvanaistraat", "364, Plaszoom", "125, Tinbergenlaan"],
  "Utrecht" => ["Torenburg 6", "Prinses Beatrixstraat 8", "Mozartlaan 29", "Orchideeënstraat 11", "Scharenslijperspad 25"],
  "The Hague" => ["Van Marumstraat 14", "Vijzelstraat 2", "Johannes Vijghstraat 28", "Rijnstraat 15", "Berkter Hei 2"]
}

nl_addresses.each do |city, array|
  array.each do |street|
    file = URI.open("https://source.unsplash.com/random/600x400/?#{city}")
    price = rand(39..109)
    description = "- Free parking on site\n
                  - Indoor swimming pool\n
                  - Not suitable for youth groups\n
                  - Optional: Bedlinen incl towels\n\n

                  No pets allowed\n
                  Minimum age: 18 years"
    flat = Flat.new(address: street, city: city, flat_location: "NL", price: price, user: admin, description: description)
    flat.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
    flat.save!

    start_date = Date.today
    duration = rand(3..7)
    end_date = start_date + duration
    booking = Booking.new(start_date: start_date, end_date: end_date, user: eirene)
    booking.flat = flat
    booking.save!
  end
end

puts "30 flats in NL created with 1 booking for each flat!"
# puts "---\n"
# puts "Creating 10 flats around the world..."

# 10.times do
#   address = Faker::Address
#   street = address.full_address
#   city = address.city
#   country = address.country
#   # file = URI.open("https://source.unsplash.com/random/600x400/?#{city}")
#   price = rand(39..109)
#   flat = Flat.new(address: street, city: city, flat_location: country, price: price, user: admin)
#   # flat.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
#   flat.save!
# end

# puts "10 flats created!"
