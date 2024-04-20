class AddBuffetToEvent < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :buffet, null: false, foreign_key: true
  end
end
