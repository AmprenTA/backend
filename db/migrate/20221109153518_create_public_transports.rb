class CreatePublicTransports < ActiveRecord::Migration[6.1]
  def change
    create_table :public_transports do |t|
      t.integer :transport_type, null: false
      t.float :total_km, null: false
      t.float :carbon_footprint, null: false, default: 0
      t.references :footprint, foreign_key: true

      t.timestamps
    end
  end
end
