class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :pricing_model_id

      t.timestamps
    end
    add_index :clients, :pricing_model_id
  end
end
