class ChangeDarkModeValueToDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :dark_mode, false

  end
end
