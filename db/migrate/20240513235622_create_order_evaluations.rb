class CreateOrderEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :order_evaluations do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :rating
      t.string :service_opinion

      t.timestamps
    end
  end
end
