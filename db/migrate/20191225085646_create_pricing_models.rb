class CreatePricingModels < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_models do |t|
      t.string :pricing_strategy
      t.integer :amount_cents
      t.decimal :percentage, precision: 4, scale: 2
      t.boolean :use_persantage, default: false

      t.timestamps
    end
  end
end
