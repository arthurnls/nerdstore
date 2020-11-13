class AddTaxPstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :tax_pst, :decimal
  end
end
