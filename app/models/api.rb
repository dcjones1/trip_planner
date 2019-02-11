require_relative 'api_key.rb'
# require 'net/http'
# require 'json'
require 'amadeus'
require 'awesome_print'
require 'byebug'

class Api

  def amadeus_call
    origin = "NYC"
    destination = "MAD"
    departure_date = "2019-08-01"

    amadeus = Amadeus::Client.new(client_id: API_KEY, client_secret: API_SECRET)
    response = amadeus.shopping.flight_offers.get(origin: origin, destination: destination, departureDate: departure_date, nonStop: true, travelClass: "ECONOMY", max: 10)

    hash = response.result
    hash["data"].each do |hash, i|
      show_transit_options(hash)
    end
  end

  def show_transit_options(hash)
    transit_hash = {}
    flight = hash["offerItems"][0]["services"][0]["segments"][0]
    # make each loop
    transit_hash[:origin] = flight["flightSegment"]["departure"]["iataCode"]
    transit_hash[:destination] = flight["flightSegment"]["arrival"]["iataCode"]
    transit_hash[:date] = flight["flightSegment"]["departure"]["at"]
    transit_hash[:departure_time] = flight["flightSegment"]["departure"]["at"]
    transit_hash[:arrival_time] = flight["flightSegment"]["arrival"]["at"]
    transit_hash[:duration] = flight["flightSegment"]["duration"]
    transit_hash[:price] = hash["offerItems"][0]["price"]["total"]
    transit_hash[:leg] = "Origin"
    transit_hash[:trip_id] = 1

  end
end

# url = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=#{origin}&destination=#{destination}&departureDate=#{departure_date}&max=5"
# uri = URI(url)
# response = NET::HTTP.get(uri)
# JSON.parse(response)
