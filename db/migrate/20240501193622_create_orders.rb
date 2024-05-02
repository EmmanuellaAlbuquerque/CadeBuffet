class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.date :event_date
      t.integer :qty_invited
      t.string :description
      t.string :code
      t.string :address
      t.integer :status

      t.timestamps
    end
  end
end
