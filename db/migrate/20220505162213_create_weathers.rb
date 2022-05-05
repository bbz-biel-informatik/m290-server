class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.date :date
      t.string :location
      t.float :temp
      t.float :temp_min
      t.float :temp_max
      t.datetime :sunrise
      t.datetime :sunset
      t.float :rain
      t.float :snow
      t.string :weather
      t.string :weather_description
      t.string :weather_icon
      t.float :wind_speed
      t.timestamps
    end
  end
end
