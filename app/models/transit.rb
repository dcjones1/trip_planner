class Transit < ApplicationRecord
  belongs_to :trip
  belongs_to :cart
end
