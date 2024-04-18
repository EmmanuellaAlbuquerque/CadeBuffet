class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :trading_name
      t.string :company_name
      t.string :registration_number
      t.string :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :description

      t.timestamps
    end
  end
end
