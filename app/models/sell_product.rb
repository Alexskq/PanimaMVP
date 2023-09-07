class SellProduct < ApplicationRecord
  belongs_to :sell
  belongs_to :shop_product

end
