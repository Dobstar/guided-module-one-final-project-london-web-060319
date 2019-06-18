class CreateCoffeeShop < ActiveRecord::Migration[5.0]
  def change
    create_table :coffee_shops do |t|
      t.string :name
      t.string :location
      t.integer :street_id
    end 
  end 
end 
