class RenameColumnDescriptionToEventDetails < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :description, :event_details
  end
end
