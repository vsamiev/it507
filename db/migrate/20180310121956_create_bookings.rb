class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.date :check_in
      t.date :check_out
      t.references :guest, foreign_key: true
      t.references :room, foreign_key: true
      t.references :manager, foreign_key: true

      t.timestamps
    end
  end
end
