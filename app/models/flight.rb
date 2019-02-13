class Flight < ApplicationRecord
  belongs_to :trip

  validates :origin, presence: true
  validates :destination, presence: true
  validates :departure_date, presence: true

  def self.codes
    @codes = Api.new
    array = @codes.get_all_airport_codes
    array
  end
end
