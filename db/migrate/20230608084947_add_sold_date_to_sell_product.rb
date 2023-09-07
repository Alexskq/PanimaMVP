class AddSoldDateToSellProduct < ActiveRecord::Migration[7.0]
  def change
    add_column(:sell_products, :sold_date, :datetime, default: -> { 'CURRENT_TIMESTAMP' })
  end
end
