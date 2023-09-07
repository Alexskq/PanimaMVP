class ShopProduct < ApplicationRecord
  belongs_to :shop
  belongs_to :product
  has_many :sell_products, dependent: :destroy

end
