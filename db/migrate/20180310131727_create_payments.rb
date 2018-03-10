class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :balance, precision: 8, scale: 2
      t.string :is_corporate
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
