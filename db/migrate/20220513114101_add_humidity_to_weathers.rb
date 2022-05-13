class AddHumidityToWeathers < ActiveRecord::Migration[7.0]
  def change
    add_column :weathers, :humidity, :float
  end
end
