class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  # has_many :images

  ###################
  # Adding image upload
  has_many_attached :images
  ###################

  # Many to Many Relationship to Users table
  has_many :order_details
  has_many :orders, through: :order_details

  validates :name, :price, :stock_quantity, presence: true
  validates :name, uniqueness: true
end
