class AddPaymentIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_id, :integer
  end
end
