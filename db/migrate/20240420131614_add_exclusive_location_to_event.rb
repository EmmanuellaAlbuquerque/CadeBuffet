class AddExclusiveLocationToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :exclusive_location, :boolean, default: false
  end
end
