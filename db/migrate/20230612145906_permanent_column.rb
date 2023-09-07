class PermanentColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :shop_products, :permanent?, :permanent
  end
end
