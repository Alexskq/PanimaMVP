class AddRackToOrderProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :order_products, :rack, :integer
  end
end
