class Trip < ApplicationRecord
  belongs_to :user
  attr_accessor :origin_address, :origin_radius, :ground_mode, :options

  has_many :flights, dependent: :destroy
  has_many :grounds, dependent: :destroy

  validates :name, presence: true,  length: {maximum: 50}
  validates :description, presence: true

  def duration
  end

  def price
    self.flights.sum(&:price)
  end
end
