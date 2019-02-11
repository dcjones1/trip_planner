class SiteController < ApplicationController

  def search
    @flight = Flight.new
  end
end
