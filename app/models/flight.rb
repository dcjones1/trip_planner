class Flight < ApplicationRecord
  belongs_to :trip
  attr_accessor :origin_address, :origin_radius, :ground_mode

  def codes
    @codes = Api.new
    array = @codes.get_all_airport_codes
    array
  end
end
