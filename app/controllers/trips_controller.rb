class TripsController < ApplicationController
  include SessionsHelper
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @trips = @user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    #NOT CORRECT FIX ME
    @trip.user = current_user
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
