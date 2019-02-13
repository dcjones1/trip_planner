class AirportOption
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end
  attr_accessor :origin_address, :origin_radius, :ground_mode

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
end
