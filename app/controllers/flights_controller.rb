class FlightsController < ApplicationController
  before_action :set_flight, only: [:edit, :update, :destroy, :show, :add_to_cart]


  def index
    @flights = Flight.all
  end

  def new
    @codes = Flight.codes
    @flight = Flight.new
    if @flight.nonstop == "Yes"
      @flight.nonstop = true
    else
      @flight.nonstop = false
    end
    @option = Api.new
    @flights_list = @option.amadeus_call(flight_params)
  end

  def create
    # @flight = Flight.new(flight_params)
    @flightoption = FlightOption.all.find do |flight|
      flight.id == flight_params[:id].to_i
    end
    binding.pry
    if @flightoption.nonstop == "Yes"
      @flight = Flight.new(
        origin: @flightoption.origin,
        destination: @flightoption.destination,
        departure_date: @flightoption.departure_date,
        departure_time: @flightoption.departure_time,
        arrival_time: @flightoption.arrival_time,
        duration: @flightoption.duration,
        price: @flightoption.price,
        travel_class: @flightoption.travel_class,
        nonstop: @flightoption.nonstop,
        flight_number: @flightoption.flight_number,
        carrier: @flightoption.carrier,
      )
    else
      @flight = Flight.new(
        origin: @flightoption.origin,
        destination: @flightoption.destination,
        departure_date: @flightoption.departure_date,
        departure_time: @flightoption.departure_time,
        arrival_time: @flightoption.arrival_time,
        duration: @flightoption.duration,
        price: @flightoption.price,
        travel_class: @flightoption.travel_class,
        nonstop: @flightoption.nonstop,
        flight_number: @flightoption.flight_number,
        carrier: @flightoption.carrier,
        connection_origin: @flightoption.connection_origin,
        connection_destination: @flightoption.connection_destination,
        connection_departure_date: @flightoption.departure_date,
        connection_departure_time: @flightoption.departure_time,
        connection_arrival_time: @flightoption.arrival_time,
        connection_duration: @flightoption.duration
      )
    end
    @flight.trip = current_trip
    if @flight.save
      redirect_to flight_path(@flight)
    else
      render :new
    end
  end

  def update
    if @flight.update(flight_params)
      redirect_to flight_path(@flight)
    else
      render :edit
    end
  end

 def add_to_cart
   current_cart << @flight.id
   redirect_to flights_path
 end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def flight_params
    params.require(:flight).permit(:origin, :destination, :departure_date, :departure_time, :arrival_time, :duration, :price, :travel_class, :nonstop, :carrier, :flight_number, :connection_origin, :connection_destination, :connection_departure_date, :connection_departure_time, :connection_arrival_time, :connection_duration, :id)
  end
end
