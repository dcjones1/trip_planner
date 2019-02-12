require_relative 'api_key.rb'
require 'net/http'
require 'json'
require 'amadeus'
require 'awesome_print'
require 'byebug'
require 'pry'

class Api

  def amadeus_call(flight_hash)
    origin = flight_hash["origin"]
    destination = flight_hash["destination"]
    departure_date = flight_hash["departure_date"]
    travel_class = flight_hash["travel_class"]
    nonstop = flight_hash["nonstop"]

    amadeus = Amadeus::Client.new(client_id: API_KEY, client_secret: API_SECRET)
    response = amadeus.shopping.flight_offers.get(origin: origin, destination: destination, departureDate: departure_date, nonStop: nonstop, travelClass: travel_class, max: 10)

    hash = response.result
    hash["data"].map do |hash|
      flight = FlightOption.new(hash)
      if hash["offerItems"][0]["services"][0]["segments"][0]["flightSegment"]["arrival"]["iataCode"] == destination.upcase
        flight.nonstop = "Yes"
      else
        flight.nonstop = "No"
      end
      flight
    end
  end

  def maps_call
    origin = "1440+G+Street+NW+Washington+DC"
    destination = "Ronald Reagan National Airport"
    mode = "transit"

    url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=#{mode}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
  end
end

# put me into rails console
# mode = Api.new
# hash = mode.maps_call
# ap hash
