class AddLocationToFootprints < ActiveRecord::Migration[6.1]
  def change
    add_column :footprints, :location, :string
  end
end
