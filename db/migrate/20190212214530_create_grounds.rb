class CreateGrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :grounds do |t|
      t.string :origin
      t.string :destination
      t.string :duration
      t.string :mode
      t.string :directions, array: true
      t.belongs_to :trip, foreign_key: true

      t.timestamps
    end
  end
end
