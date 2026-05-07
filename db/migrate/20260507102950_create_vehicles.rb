class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :vin, null: false
      t.date :year
      t.string :make
      t.string :model
      t.string :mileage
      t.string :color
      t.date :purchase_date
      t.timestamps
    end
    add_index :vehicles, :vin, unique: true
  end
end

# customer_id (FK), vin (unique, 17 chars), year (1900-current), make, model, mileage (>=0),
# color, purchase_date, timestamps