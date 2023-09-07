class AddQuantityToOrdersColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :order_products, :quantity_product, :integer
  end
end
