class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.references :sensor, null: false
      t.float :temperature, null: false
      t.float :humidity, null: false
      t.float :soil_moisture, null: false
    end
  end
end
