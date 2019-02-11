class TransitsController < ApplicationController
  before_action :set_transit, only: [:edit, :destroy, :show]

  def index
    @transits = Transit.all
  end

  def new
    @trip = Trip.new
  end

  def options
    @flight = Api.new
    @hash = @flight.show_transit_options(@flight.amadeus_call)
  end

  private

  def set_transit
    @transit = Transit.find(params[:id])
  end
end
