# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
Trip.destroy_all
Flight.destroy_all
Ground.destroy_all


10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Name.first_name + "@gmail.com"
  )
end

10.times do
  x = User.all.first.id
  x += 1
  Trip.create(
    name: Faker::Address.country,
    description: Faker::Book.genre,
    duration: Faker::Number.number(2) + "days",
    price: Faker::Number.number(4),
    user_id: x
  )
end

20.times do
  Flight.create(
    origin: Faker::Address.country,
    destination: Faker::Address.country,
    departure_date: Faker::Date.forward(50),
    return_date: Faker::Date.forward(50),
    travel_class: "ECONOMY",
    nonstop: true,
    departure_time: "9:00 am",
    arrival_time: "5:00 pm",
    duration: Faker::Number.number(2) + "hours",
    price: Faker::Number.number(3),
    leg: "origin",
    trip_id: rand(Trip.all.first.id..Trip.all.last.id)
  )
end

20.times do
  Flight.create(
    origin: Faker::Address.country,
    destination: Faker::Address.country,
    departure_date: Faker::Date.forward(50),
    return_date: Faker::Date.forward(50),
    travel_class: "ECONOMY",
    nonstop: true,
    departure_time: "9:00 am",
    arrival_time: "5:00 pm",
    duration: Faker::Number.number(1) + "hours",
    price: Faker::Number.number(3),
    leg: "destination",
    trip_id: rand(Trip.all.first.id..Trip.all.last.id)
  )
end

Ground.create(
  origin: "1440 G Street NW Washington DC",
  destination: "Ronald Reagon Washington National Airport",
  duration: "28 mins",
  mode: "transit",
  directions: ["Walk to Metro Center Station", "Head <b>east</b> on <b>G St NW</b> toward <b>14th St NW</b>", "Turn <b>right</b> onto <b>13th St NW</b>", "Metro rail towards Franconia-Springfield", "Walk to Ronald Reagan Washington National Airport (DCA), Arlington, VA 22202, USA", "Head <b>south</b> on <b>Aviation Cir</b>", "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>"],
  trip_id: rand(Trip.all.first.id..Trip.all.last.id))

# User.create(first_name: "Chris", last_name: "Jones", email: "fake@gmail.com")
# Trip.create(name: "France", duration: "5 days", price: 1400, user_id: 1)
# Transit.create(origin: "DC", destination: "France", date: "12/12/2019", departure_time: "9:00 am", arrival_time: "5:00 pm", duration: "12 hours", price: 500, leg: "origin", trip_id: 1)
