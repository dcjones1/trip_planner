class StaticController < ApplicationController
  before_action :rootmaker
  before_action :tripmaker

  def search
    @flight = Flight.new
  end
end
