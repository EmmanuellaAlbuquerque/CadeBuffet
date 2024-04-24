class AddUniqueConstrainToItinInClients < ActiveRecord::Migration[7.1]
  def change
    add_index :clients, :itin, unique: true
  end
end
