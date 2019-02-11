class TransitsController < ApplicationController
  before_action :set_transit, only: [:show, :edit, :update, :destroy]

  def index
    @transits = Transit.all
  end

  def new
    @transit = Transit.new
  end

  def create
      @transit = Transit.new(trip_params)
      if @transit.save
        redirect_to transit_path(@transit)
      else
        render :new
      end
  end

  def options
    @flight = Api.new
    @hash = @flight.show_transit_options(@flight.amadeus_call)
  end

  def edit
  end

  def update
    if @transit.update(transit_params)
      redirect_to transit_path(@transit)
    else
      render :edit
    end
  end

  private

  def set_transit
    @transit = Transit.find(params[:id])
  end

  def transit_params
    params.require(:transit).permit(:origin, :destination, :date, :nonStop, :travelClass)
  end
end
