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
    hash["data"].map do |hash|
      FlightOption.new(hash)
    end
  end
end

# url = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=#{origin}&destination=#{destination}&departureDate=#{departure_date}&max=5"
# uri = URI(url)
# response = NET::HTTP.get(uri)
# JSON.parse(response)
