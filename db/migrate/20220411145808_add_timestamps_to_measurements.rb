class AddTimestampsToMeasurements < ActiveRecord::Migration[7.0]

  def up
    execute "DELETE FROM measurements WHERE true"
    add_timestamps :measurements, null: false
  end

  def down
    remove_timestamps :measurements
  end
end
