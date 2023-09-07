class CreateSellProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :sell_products do |t|
      t.references :sell, null: false, foreign_key: true
      t.references :shop_product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
