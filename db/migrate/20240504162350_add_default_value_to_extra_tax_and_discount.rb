class AddDefaultValueToExtraTaxAndDiscount < ActiveRecord::Migration[7.1]
  def change
    change_column :order_payments, :extra_tax, :integer, default: 0
    change_column :order_payments, :discount, :integer, default: 0
  end
end
