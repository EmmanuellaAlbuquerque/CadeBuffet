class ChangeColumnOrdersIdToOrderId < ActiveRecord::Migration[7.1]
  def change
    rename_column :order_payments, :orders_id, :order_id
  end
end
