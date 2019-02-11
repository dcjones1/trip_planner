class FlightOption
  attr_accessor :origin, :destination, :departure_date, :return_date, :departure_time, :arrival_time, :duration, :price, :travel_class, :nonstop, :carrier, :flight_number, :leg, :trip_id


  def initialize(hash)
    flight = hash["offerItems"][0]["services"][0]["segments"][0]
    @origin = flight["flightSegment"]["departure"]["iataCode"]
    @destination = flight["flightSegment"]["arrival"]["iataCode"]
    @departure_date = DateTime.strptime(flight["flightSegment"]["departure"]["at"])
    # @return_date
    @departure_time = DateTime.strptime(flight["flightSegment"]["departure"]["at"])
    @arrival_time = DateTime.strptime(flight["flightSegment"]["arrival"]["at"])
    @duration = flight["flightSegment"]["duration"]
    @price = hash["offerItems"][0]["price"]["total"]
    @travel_class = flight["pricingDetailPerAdult"]["travelClass"]
    @nonstop = false
    @carrier = flight["flightSegment"]["operating"]["carrierCode"]
    @flight_number = flight["flightSegment"]["operating"]["number"]
    @leg = "origin"
    @trip_id = 1
  end
end
