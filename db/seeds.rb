# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


Trip.destroy_all
Flight.destroy_all

5.times do
  Trip.create(
    name: Faker::Address.country,
    duration: Faker::Number.number(2) + "days",
    price: Faker::Number.number(4),
    user_id: 1
  )
end

5.times do
  Trip.create(
    name: Faker::Address.country,
    duration: Faker::Number.number(2) + "days",
    price: Faker::Number.number(4),
    user_id: 2
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
    trip_id: rand(1..10)
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
    trip_id: rand(1..10)
  )
end
