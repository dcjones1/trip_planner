class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  #  @trip.transits.build for each flight and mode of transportation
  end

  def create
    @trip = Trip.new(trip_params)
    #NOT CORRECT FIX ME
    @trip.user = User.find(1)
    if @trip.save
      redirect_to
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

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name)
  end
end
