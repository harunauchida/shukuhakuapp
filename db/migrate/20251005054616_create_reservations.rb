class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :check_in
      t.date :check_out
      t.integer :number_of_people
      t.integer :total_price
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
