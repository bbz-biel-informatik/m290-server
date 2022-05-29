class AddSunPositionToWeathers < ActiveRecord::Migration[7.0]
  def change
    add_column :weathers, :sun_position, :float
    add_column :weathers, :sun_height, :float
  end
end
