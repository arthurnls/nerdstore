class Province < ApplicationRecord
  has_many :customers

  validates :name, :code, presence: true
  validates :name, :code, uniqueness: true
end
