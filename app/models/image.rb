class Image < ApplicationRecord
  belongs_to :product

  validates :path, :position_order, presence: true
end
