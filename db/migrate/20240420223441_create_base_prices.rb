class CreateBasePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :event_base_prices do |t|
      t.float :min_price
      t.integer :chosen_category_day
      t.float :extra_price_per_person
      t.float :extra_price_per_duration
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
