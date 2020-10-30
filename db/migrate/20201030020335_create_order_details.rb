class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quatity
      t.decimal :purchase_price

      t.timestamps
    end
  end
end
