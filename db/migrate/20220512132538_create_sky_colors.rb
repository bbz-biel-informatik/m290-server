class CreateSkyColors < ActiveRecord::Migration[7.0]
  def change
    create_table :sky_colors do |t|
      t.string :location
      t.integer :r
      t.integer :g
      t.integer :b

      t.timestamps
    end
  end
end
