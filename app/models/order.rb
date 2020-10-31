class Order < ApplicationRecord
  belongs_to :customer

  # Many to Many Relationship to Users table
  has_many :order_details
  has_many :products, through: :order_details
end
