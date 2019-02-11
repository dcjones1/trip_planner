require_relative 'api_key.rb'
require 'net/http'
require 'json'
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
    hash["data"].map do |hash|
      FlightOption.new(hash)
    end
  end

  def maps_call
    origin = "1440+G+Street+NW+Washington+DC"
    destination = "Ronald Reagan National Airport"
    mode = "driving"

    url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=#{mode}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)

    # parsed_response.result
  end
end
# 
# drive = Api.new
# drive.maps_call
# byebug
# puts "hey"
