class Trip < ApplicationRecord
  belongs_to :user
  has_many :transits, dependent: :destroy
end
