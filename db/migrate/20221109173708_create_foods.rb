class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.references :footprint, foreign_key: true
      t.float :min_carbon_footprint, null: false, default: 0
      t.float :max_carbon_footprint, null: false, default: 0
      t.integer :beef, null: false, default: 0
      t.integer :lamb, null: false, default: 0
      t.integer :poultry, null: false, default: 0
      t.integer :pork, null: false, default: 0
      t.integer :fish, null: false, default: 0
      t.integer :milk_based, null: false, default: 0
      t.integer :cheese, null: false, default: 0
      t.integer :eggs, null: false, default: 0
      t.integer :coffee, null: false, default: 0
      t.integer :vegetables, null: false, default: 0
      t.integer :bread, null: false, default: 0

      t.timestamps
    end
  end
end
