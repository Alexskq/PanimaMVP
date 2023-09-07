class CreateSells < ActiveRecord::Migration[7.0]
  def change
    create_table :sells do |t|
      t.references :user, null: false, foreign_key: true
      t.float :total_price

      t.timestamps
    end
  end
end
