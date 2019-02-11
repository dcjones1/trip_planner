class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :origin
      t.string :destination
      t.string :departure_date
      t.string :return_date
      t.string :departure_time
      t.string :arrival_time
      t.string :duration
      t.float :price
      t.string :travel_class
      t.boolean :nonstop
      t.string :flight_number
      t.string  :carrier
      t.string :leg
      t.belongs_to :trip, foreign_key: true

      t.timestamps
    end
  end
end
