class AddBuffetIdToSale < ActiveRecord::Migration[7.1]
  def change
    add_reference :sales, :buffet, null: false, foreign_key: true
  end
end
