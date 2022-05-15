class AddMoonPhaseToWeathers < ActiveRecord::Migration[7.0]
  def change
    add_column :weathers, :moon_phase, :float
  end
end
