class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders
  
  validates :name, :email, :password, :address_line, :city, :postal_code, :country, :province, presence: true
  validates :email, uniqueness: true
end


