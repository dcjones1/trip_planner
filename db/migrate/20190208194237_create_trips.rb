class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :duration
      t.float :price
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
