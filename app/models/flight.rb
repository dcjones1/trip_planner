class Flight < ApplicationRecord
  belongs_to :trip

  def origin_radius
  end

  def destination_radius
  end

end
