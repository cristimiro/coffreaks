class CreateCoffeeShops < ActiveRecord::Migration[8.0]
  def change
    create_table :coffee_shops do |t|
      t.string :name, null: false
      t.float :lat, null: false
      t.float :long, null: false
      t.string :address, null: false
      t.string :start_time, null: false
      t.string :end_time, null: false

      t.timestamps
    end
  end
end
