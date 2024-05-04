class AddColumnToOrderPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :order_payments, :standard_price, :integer
  end
end
