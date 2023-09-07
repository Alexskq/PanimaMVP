class CreateUserShops < ActiveRecord::Migration[7.0]
  def change
    create_table :user_shops do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
