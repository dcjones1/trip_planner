class TransitsController < ApplicationController
  before_action :set_transit, only: [:edit, :destroy, :show]

  def index
    @transits = Transit.all
  end

  private

  def set_transit
    @transit = transit.find(params[:id])
  end
end
