class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.references :footprint, foreign_key: true

      t.timestamps
    end
  end
end
