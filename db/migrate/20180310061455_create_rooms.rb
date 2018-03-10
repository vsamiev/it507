class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :number
      t.references :building, foreign_key: true

      t.timestamps
    end
  end
end
