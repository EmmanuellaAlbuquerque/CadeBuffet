class RenameColumnAddressToEventAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :address, :event_address
  end
end
