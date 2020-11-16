class Department < ApplicationRecord
  has_many :categories
  has_many :products, through: :categories

  validates :name, presence: true
  validates :name, uniqueness: true
end
