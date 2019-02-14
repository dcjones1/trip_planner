class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    #NOT CORRECT FIX ME
    if !@trip.user_id
      @trip.user_id = User.find(User.all.first.id).id
    end
    byebug
    if @trip.save
      redirect_to new_ground_path
    else
      render :new
    end
  end

  def update
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  def airports
  end

  def options
    @origin = options_params[:options][:origin_address]
    @radius = options_params[:options][:origin_radius]
    @mode = options_params[:options][:ground_mode]
    @destination = options_params[:options][:destination]
    @departure_date = options_params[:options][:departure_date]
    @travel_class = options_params[:options][:travel_class]
    @nonstop = options_params[:options][:nonstop]

    api = Api.new
    array = api.get_airport_codes({origin: @origin, radius: @radius})
    origin_array = []

    array.each do |airport_array|
      origin_array << airport_array[1]
    end

    @flight = Flight.new
    if @flight.nonstop == "Yes"
      @flight.nonstop = true
    else
      @flight.nonstop = false
    end
    # BAR FOR EMPTY ARRAYS
    if origin_array != []
      new_params = flight_params["options"].merge({"origin": origin_array})
      @option = Api.new
      @flights_list = @option.amadeus_call(new_params)
    else
      redirect_to new_flight_path
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :description)
  end

  def options_params
    params.permit(options: [:origin_radius, :origin_address, :ground_mode, :destination, :departure_date, :travel_class, :nonstop])
  end

  def flight_params
    params.permit(options: [:destination, :departure_date, :travel_class, :nonstop])
  end
end
