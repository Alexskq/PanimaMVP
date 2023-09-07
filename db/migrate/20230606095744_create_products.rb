class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :buy_price
      t.string :category
      t.integer :ean

      t.timestamps
    end
  end
end
