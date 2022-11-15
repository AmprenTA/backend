class CreateFootprints < ActiveRecord::Migration[6.1]
  def change
    create_table :footprints do |t|
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
