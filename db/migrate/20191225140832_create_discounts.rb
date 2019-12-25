class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :compare_strategy
      t.string :attribute_matcher
      t.integer :amount_cents
      t.decimal :percentage, precision: 4, scale: 2
      t.string :operator_from
      t.string :operator_to
      t.integer :quantity_from
      t.integer :quantity_to
      t.boolean :use_persantage, default: false

      t.timestamps
    end
  end
end
