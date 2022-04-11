class CreateSensors < ActiveRecord::Migration[7.0]
  def change
    create_table :sensors do |t|
      t.string :mac_address, null: false
      t.string :student

      t.timestamps
    end
  end
end
