class Transit < ApplicationRecord
  belongs_to :trip
  belongs_to :cart

  def origin_radius
  end

  def destination_radius
  end
end
