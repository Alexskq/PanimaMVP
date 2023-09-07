class ChangeEanToString < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :ean
    add_column :products, :ean, :string
  end
end
