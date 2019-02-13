class GroundsController < ApplicationController
  before_action :set_ground, only: [:show, :edit, :update, :destroy ]

    def index
      @grounds = Ground.all
    end

    def new
      @ground = Ground.new
    end

    def create
      @ground = Ground.new
      @airport = Api.new
      @hash = @airport.get_airport_codes(ground_params)
      # @hash = @airport.get_distance_hash(ground_params[:origin])
      # @airport_options = @airport.find_airports_within_radius({radius: ground_params[:origin_radius], hash: @hash})
      # codes = {"Ronald Reagan Washington National Airport": "DCA",
      #   "Washington Dulles International Airport": "IAD",
      #   "Baltimore/Washington International Thurgood Marshal Airport": "BWI",
      #   "Richmond International Airport": "RIC","Philadelphia International Airport": "PHL",
      #   "Newport News Williamsburg International Airport": "PHF","Norfolk International Airport":"ORF",
      #   "Roanoke Regional Woodrum Field": "ROA", "Newark Liberty International Airport": "EWR", "LaGuardia Airport": "LGA","John F. Kennedy International Airport": "JFK"}
      #   @airport_hash = []
      #   @airport_options.each do |option|
      #   @airport_hash << {option.values[0].to_sym => codes[option.values[0].to_sym]}
      # end
byebug

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
end
