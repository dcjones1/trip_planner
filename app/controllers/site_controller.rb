class SiteController < ApplicationController

  def search
    @flight = Flight.new
  end

  def airports
    @flight = Flight.new
  end
end
