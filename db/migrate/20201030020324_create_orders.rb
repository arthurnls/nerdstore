class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :cost_shipping
      t.decimal :cost_GST
      t.decimal :cost_PST
      t.decimal :cost_HST
      t.decimal :cost_discount
      t.string :shipping_address

      t.timestamps
    end
  end
end
