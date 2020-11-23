class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quatity, :purchase_price, :product, :order, presence: true

  validates :purchase_price, numericality: true
  validates :quatity, numericality: { only_integer: true }
end
