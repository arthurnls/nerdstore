class Category < ApplicationRecord
  belongs_to :department
  has_many :products
  
  validates :name, :department, presence: true
  validates :name, uniqueness: true
end
