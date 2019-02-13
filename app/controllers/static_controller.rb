class StaticController < ApplicationController
  def search
    @flight = Flight.new
  end
end
