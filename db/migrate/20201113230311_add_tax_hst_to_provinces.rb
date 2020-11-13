class AddTaxHstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :tax_hst, :decimal
  end
end
