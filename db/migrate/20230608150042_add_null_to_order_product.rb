class AddNullToOrderProduct < ActiveRecord::Migration[7.0]
  def change
    change_column :order_products, :quantity_product, :integer, null: false
  end
end
