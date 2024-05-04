class RenameColumnPaymentMethodsIdToPaymentMethodId < ActiveRecord::Migration[7.1]
  def change
    rename_column :order_payments, :payment_methods_id, :payment_method_id
  end
end
