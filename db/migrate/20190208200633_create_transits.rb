class CreateTransits < ActiveRecord::Migration[5.2]
  def change
    create_table :transits do |t|
      t.string :origin
      t.string :destination
      t.string :date
      t.string :departure_time
      t.string :arrival_time
      t.string :duration
      t.float :price
      t.string :leg
      t.belongs_to :trip, foreign_key: true
      t.belongs_to :cart, foreign_key: true

      t.timestamps
    end
  end
end
