class Ground < ApplicationRecord
  belongs_to :trip
  attr_accessor :origin_radius 
end
