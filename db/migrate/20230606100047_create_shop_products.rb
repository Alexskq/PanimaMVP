class CreateShopProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :shop_products do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :stock
      t.float :selling_price
      t.integer :max_stock
      t.float :rating
      t.date :dlc
      t.string :rack

      t.timestamps
    end
  end
end
