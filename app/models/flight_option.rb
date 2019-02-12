class FlightOption
  attr_accessor :origin, :destination, :departure_date, :return_date, :departure_time, :arrival_time, :duration, :price, :travel_class, :nonstop, :carrier, :flight_number, :leg, :trip_id, :connection_origin, :connection_destination, :connection_departure_date, :connection_departure_time, :connection_arrival_time, :connection_duration


  def initialize(hash)
    flight = hash["offerItems"][0]["services"][0]["segments"][0]
    @origin = flight["flightSegment"]["departure"]["iataCode"]
    @destination = flight["flightSegment"]["arrival"]["iataCode"]
    @departure_date = DateTime.strptime(flight["flightSegment"]["departure"]["at"])
    # @return_date
    @departure_time = DateTime.strptime(flight["flightSegment"]["departure"]["at"])
    @arrival_time = DateTime.strptime(flight["flightSegment"]["arrival"]["at"])
    @duration = flight["flightSegment"]["duration"]
    @price = hash["offerItems"][0]["price"]["total"].to_f
    @travel_class = flight["pricingDetailPerAdult"]["travelClass"]
    #shouldn't be true false, should match user input
    @nonstop = ''
    @carrier = flight["flightSegment"]["operating"]["carrierCode"]
    @flight_number = flight["flightSegment"]["operating"]["number"]
    @leg = ''
    @trip_id = ''
    if hash["offerItems"][0]["services"][0]["segments"][1]
      connection = hash["offerItems"][0]["services"][0]["segments"][1]
      @connection_origin = connection["flightSegment"]["departure"]["iataCode"]
      @connection_destination = connection["flightSegment"]["arrival"]["iataCode"]
      @connection_departure_date = DateTime.strptime(connection["flightSegment"]["departure"]["at"])
      @connection_departure_time = DateTime.strptime(connection["flightSegment"]["departure"]["at"])
      @connection_arrival_time = DateTime.strptime(connection["flightSegment"]["arrival"]["at"])
      @connection_duration = connection["flightSegment"]["duration"]
    end
  end
end
