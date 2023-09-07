class Sell < ApplicationRecord
  belongs_to :user
  has_many :sell_products, dependent: :destroy
end
