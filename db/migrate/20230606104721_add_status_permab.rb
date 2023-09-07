class AddStatusPermab < ActiveRecord::Migration[7.0]
  def change
    add_column :shop_products, :status, :string
    add_column :shop_products, :permanent?, :boolean
  end
end
