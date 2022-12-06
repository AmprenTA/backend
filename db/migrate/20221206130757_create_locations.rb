class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :town
      t.string :county

      t.timestamps
    end
  end
end
