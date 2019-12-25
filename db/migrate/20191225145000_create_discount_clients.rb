class CreateDiscountClients < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_clients do |t|
      t.integer :discount_id
      t.integer :client_id

      t.timestamps
    end
    add_index :discount_clients, :discount_id
    add_index :discount_clients, :client_id
  end
end
