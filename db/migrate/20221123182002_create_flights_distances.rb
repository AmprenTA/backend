class CreateFlightsDistances < ActiveRecord::Migration[6.1]
  def change
    create_table :flights_distances do |t|
      t.string :from, null: false, default: ""
      t.string :to, null: false, default: ""
      t.string :km, null: false, default: ""
      t.float :carbon_footprint, null: false, default: 0.0

      t.timestamps
    end
  end
end
