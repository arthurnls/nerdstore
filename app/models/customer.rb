class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  has_secure_password

  validates :name, :email, :password_digest, :address_line, :city, :postal_code, :country, :province, presence: true
  validates :email, uniqueness: true
end
