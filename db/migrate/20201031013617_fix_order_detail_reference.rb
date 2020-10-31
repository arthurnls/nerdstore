class FixOrderDetailReference < ActiveRecord::Migration[6.0]
  def change
    remove_reference :order_details, :customer
    add_reference :order_details, :product
  end
end
