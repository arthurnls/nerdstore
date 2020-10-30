class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :address_line
      t.string :city
      t.string :postal_code
      t.string :country
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
