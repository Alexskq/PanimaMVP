class ChangeTimeInOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :delivered_date
    add_column :orders, :delivered_date, :datetime

  end
end
