class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :phone, null: false
      t.date :date_of_birth
      t.string :address
      t.string :city
      t.string :state, null: false
      t.string :zip_code, null: false
      t.timestamps
    end
    add_index :customers, :email, unique: true
  end
end

# first_name, last_name, email (unique), phone (10 digits), date_of_birth, address, city, state (2
# chars), zip_code (5 digits), timestamps