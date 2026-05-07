class CreateServiceContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :service_contracts do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.string :contract_number 
      t.string :coverage_type
      t.string :coverage_duration_months
      t.integer :deductible_amount
      t.integer :monthly_payment
      t.date :start_date
      t.date :end_date
      t.string :notes
      t.timestamps
    end
    add_index :service_contracts, :contract_number, unique: true
  end
end

# customer_id (FK), vehicle_id (FK), contract_number (unique, auto-generated), coverage_type
# (basic/standard/premium), coverage_duration_months (12/24/36/48/60), deductible_amount (>=0),
# monthly_payment (>0), start_date, end_date (auto-calculated), notes, timestamps