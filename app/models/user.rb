class User < ApplicationRecord
  has_one :user

  def name
    self.first_name + self.last_name
  end
end
