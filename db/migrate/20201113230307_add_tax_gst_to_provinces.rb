class AddTaxGstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :tax_gst, :decimal
  end
end
