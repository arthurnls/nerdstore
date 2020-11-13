class Province < ApplicationRecord
  has_many :customers

  validates :name, :code, presence: true
  validates :name, :code, uniqueness: true
  validates_length_of :code, minimum: 2, maximum: 2, allow_blank: false
  validates :tax_pst, numericality: true, allow_nil: true
  validates :tax_gst, numericality: true, allow_nil: true
  validates :tax_hst, numericality: true, allow_nil: true
end
