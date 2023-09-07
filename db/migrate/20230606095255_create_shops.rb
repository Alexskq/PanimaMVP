class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :address
      t.float :surface
      t.integer :capacity

      t.timestamps
    end
  end
end
