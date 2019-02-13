class GroundsController < ApplicationController
  before_action :set_ground, only: [:show, :edit, :update, :destroy ]
  helper_method :find_airport

    def index
      @grounds = Ground.all
    end

    def new
      @ground = Ground.new
    end

# def airport
#   @ground = Ground.new
# end
    def create
      @ground = Ground.new
      @airport = Api.new
      @hash = @airport.get_distance_hash(ground_params[:origin])
      @airport_options = @airport.find_airports_within_radius({radius: ground_params[:origin_radius], hash: @hash})
@airport_options.each do |distance, airport|
  @option = Api.new
  @flights_list = @option.amadeus_call(flight_params)
byebug
end

      @ground = Ground.new(ground_params[:origin])
      #NOT CORRECT FIX ME
      if @ground.save
        redirect_to airport_path(@ground)
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
        params.require(:ground).permit(:origin, :origin_radius, :duration, :mode, :directions)
      end

        def flight_params
          params.require(:flight).permit(:origin, :destination, :departure_date, :departure_time, :arrival_time, :duration, :price, :travel_class, :nonstop, :carrier, :flight_number, :connection_origin, :connection_destination, :connection_departure_date, :connection_departure_time, :connection_arrival_time, :connection_duration)
        end
end
