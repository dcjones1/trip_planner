class GroundsController < ApplicationController
  before_action :set_ground, only: [:show, :edit, :update, :destroy ]
  before_action :rootmaker
  before_action :tripmaker


  def index
    @grounds = Ground.all
  end

  def new
    @ground = Ground.new
  end

  def create
    @ground = Ground.new({origin: ground_params[:origin], destination: ground_params[:destination],mode: ground_params[:mode]})
    @airport = Api.new
    @hash = @airport.maps_call({origin: ground_params[:origin], destination: ground_params[:destination],mode: ground_params[:mode]})
    @ground.duration = @airport.get_duration(@hash)
    @ground.directions = @airport.get_directions_array(@hash)
    @ground.trip = current_trip
    if @ground.save
      redirect_to current_trip
    else
      render :new
    end
  end

  def update
    if @ground.update(ground_params)
      redirect_to ground_path(@ground)
    else
      render :edit
    end
  end

  private

  def set_ground
    @ground = Ground.find(params[:id])
  end

  def ground_params
    params.require(:ground).permit(:origin, :destination, :duration, :mode, :directions)
  end
end
