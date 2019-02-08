class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :destroy, :show]

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
    if @trip.save
      redirect_to @path
    else
      render :new
    end
  end

  def update
    @trip.update(trip_params)
    if @trip.save
      redirect_to @trip
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
