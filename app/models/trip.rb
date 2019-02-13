class Trip < ApplicationRecord
  belongs_to :user
  has_many :flights, dependent: :destroy
  has_many :grounds, dependent: :destroy
end
