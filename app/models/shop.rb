

class Shop < ApplicationRecord
  require "date"
  has_many :shop_products, dependent: :destroy
  has_many :orders
  belongs_to :user, optional: true

  after_create :check_stock

  def check_stock
    UpdateOrderJob.set(wait_until: Date.tomorrow.midnight).perform_later
  end
end
