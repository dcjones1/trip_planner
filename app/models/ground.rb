class Ground < ApplicationRecord
  belongs_to :trip
  attr_accessor :origin_radius

  def airports
    @airports = Api.new
    array = @airports.get_all_airports
    array
  end
end
