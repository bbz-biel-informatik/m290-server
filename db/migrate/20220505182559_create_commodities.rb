class CreateCommodities < ActiveRecord::Migration[7.0]
  def change
    create_table :commodities do |t|
      t.string :name
      t.string :symbol
      t.float :price

      t.timestamps
    end
  end
end
