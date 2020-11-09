class Department < ApplicationRecord
  has_many :categories
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
