class CreatePenalties < ActiveRecord::Migration[7.1]
  def change
    create_table :penalties do |t|
      t.integer :days_ago
      t.integer :value_percentage
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
