class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.references :footprint, foreign_key: true
      t.float :min_carbon_footprint, null: false
      t.float :max_carbon_footprint, null: false

      t.timestamps
    end
  end
end