class RenameColumnProductsFixQuantity < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :stock_quatity, :stock_quantity
  end
end
