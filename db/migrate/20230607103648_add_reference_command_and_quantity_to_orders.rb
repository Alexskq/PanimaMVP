class AddReferenceCommandAndQuantityToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_reference, :string
    add_column :orders, :quantity, :integer
  end
end
