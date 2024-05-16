class AddSpecialSaleToOrderPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :order_payments, :special_sale, :boolean, default: false
  end
end
