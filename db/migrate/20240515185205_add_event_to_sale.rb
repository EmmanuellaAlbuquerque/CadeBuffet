class AddEventToSale < ActiveRecord::Migration[7.1]
  def change
    add_reference :sales, :event, null: false, foreign_key: true
  end
end
