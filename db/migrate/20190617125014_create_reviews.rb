class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :content
      t.string :star_rating
      t.integer :user_id
      t.integer :coffee_shop_id
    end 
  end
end
