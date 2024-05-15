class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :discount_percentage
      t.boolean :on_weekdays
      t.boolean :on_weekend

      t.timestamps
    end
  end
end
