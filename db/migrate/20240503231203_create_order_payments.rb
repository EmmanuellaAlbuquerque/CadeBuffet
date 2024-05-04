class CreateOrderPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :order_payments do |t|
      t.references :orders, null: false, foreign_key: true
      t.integer :extra_tax
      t.integer :discount
      t.string :description
      t.date :validity_date
      t.references :payment_methods, null: false, foreign_key: true

      t.timestamps
    end
  end
end
