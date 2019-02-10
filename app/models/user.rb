class User < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_one :cart

  def name
    self.first_name + " " + self.last_name
  end
end
