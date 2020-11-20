class Order < ApplicationRecord
  belongs_to :customer

  # Many to Many Relationship to Users table
  has_many :order_details
  has_many :products, through: :order_details

  validates :cost_shipping, :cost_GST, :cost_PST, :cost_HST, :cost_discount, :shipping_address, :status, :customer, presence: true

  validates :cost_shipping, :cost_GST, :cost_PST, :cost_HST, :cost_discount, numericality: true
  validates :status, inclusion: { in: %w[pending paid shipped], message: "%{value} is an invalid status" }
end
