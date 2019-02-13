class Ground < ApplicationRecord
  belongs_to :trip

  validates :origin, presence: true
  validates :destination, presence: true
  validates :mode, presence: true

  def self.airports
    @airports = Api.new
    array = @airports.get_all_airports
    array
  end
end
