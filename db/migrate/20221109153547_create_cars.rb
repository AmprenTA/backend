class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.integer :fuel_type, null: false
      t.float :total_km, null: false
      t.references :footprint, foreign_key: true

      t.timestamps
    end
  end
end
