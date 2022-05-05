class CreateWaters < ActiveRecord::Migration[7.0]
  def change
    create_table :waters do |t|
      t.string :name
      t.float :flow
      t.float :level
      t.float :temperature

      t.timestamps
    end
  end
end
