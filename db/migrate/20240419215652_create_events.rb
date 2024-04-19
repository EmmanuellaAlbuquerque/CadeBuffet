class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :qty_min
      t.integer :qty_max
      t.integer :duration
      t.string :menu

      t.timestamps
    end
  end
end
