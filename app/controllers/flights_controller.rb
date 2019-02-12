class FlightsController < ApplicationController
  before_action :set_flight, only: [:edit, :update, :destroy, :show, :add_to_cart]

  def index
    @flights = Flight.all
  end

  def new
    @flight = Flight.new
    @option = Api.new
    @flights_list = @option.amadeus_call(flight_params)
  end

  def create
    @flight = Flight.new(flight_params)
    #fake trip attachment for now
    @flight.trip = Trip.find(4)
    binding.pry
    @flight.save
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
 end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def flight_params
    params.require(:flight).permit(:origin, :destination, :departure_date, :nonstop, :travel_class)
  end
end
