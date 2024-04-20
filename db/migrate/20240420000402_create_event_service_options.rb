class CreateEventServiceOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :event_service_options do |t|
      t.references :event, null: false, foreign_key: true
      t.references :service_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
