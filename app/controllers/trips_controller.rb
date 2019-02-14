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
    @trip.user = current_user
    if @trip.save
      redirect_to airports_trips_path
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

  # def flight_params
  #   params.permit(options: [:destination, :departure_date, :travel_class, :nonstop])
  # end
end
