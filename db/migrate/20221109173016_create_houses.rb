class CreateHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses do |t|
      t.float :electricity, null: false
      t.float :natural_gas, null: false
      t.float :wood, null: false
      t.references :footprint, foreign_key: true

      t.timestamps
    end
  end
end
