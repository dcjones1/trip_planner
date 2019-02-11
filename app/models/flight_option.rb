class FlightOption
  attr_accessor :origin, :destination


  def initialize(hash)
    flight = hash["offerItems"][0]["services"][0]["segments"][0]
    @origin = flight["flightSegment"]["departure"]["iataCode"]
    @destination = flight["flightSegment"]["arrival"]["iataCode"]
  end

  # def self.create_flights(hash)
  #
  #   # flight = hash["offerItems"][0]["services"][0]["segments"][0]
  #   transit_hash[:origin] = flight["flightSegment"]["departure"]["iataCode"]
  #   transit_hash[:destination] = flight["flightSegment"]["arrival"]["iataCode"]
  #   transit_hash[:date] = flight["flightSegment"]["departure"]["at"]
  #   transit_hash[:departure_time] = flight["flightSegment"]["departure"]["at"]
  #   transit_hash[:arrival_time] = flight["flightSegment"]["arrival"]["at"]
  #   transit_hash[:duration] = flight["flightSegment"]["duration"]
  #   transit_hash[:price] = hash["offerItems"][0]["price"]["total"]
  #   transit_hash[:leg] = "Origin"
  #   transit_hash[:trip_id] = 1
  #
  # end



end
