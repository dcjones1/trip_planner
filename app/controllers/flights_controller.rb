class FlightsController < ApplicationController
  before_action :set_flight, only: [:edit, :destroy, :show]

  def index
    @flights = Flight.all
  end

  def new
    @flight = Flight.new
    @option = Api.new
    @flights_list = @option.amadeus_call
  end


  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end
