class AddDefaultToStatusColumnInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column :orders, :status, :integer, default: 0
  end
end
