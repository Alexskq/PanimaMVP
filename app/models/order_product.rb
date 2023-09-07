class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  after_save :update_quantity_order

  def update_quantity_order
    order = self.order
    order.quantity += 1

    order.total_price += self.product.buy_price



    order.save
  end
end
