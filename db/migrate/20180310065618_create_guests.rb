class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :f_name
      t.string :l_name
      t.string :state

      t.timestamps
    end
  end
end
