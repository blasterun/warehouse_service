class CreateStorageObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :storage_objects do |t|
      t.string :name
      t.integer :client_id
      t.integer :price_cents
      t.decimal :square_foot_size

      t.timestamps
    end
    add_index :storage_objects, :client_id
  end
end
