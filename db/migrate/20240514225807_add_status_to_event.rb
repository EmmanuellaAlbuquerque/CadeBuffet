class AddStatusToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :status, :integer, default: 1
  end
end
