# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# PaymentModel.new(payment_type: 'dsds', amount: 0, amount_type: 'percentage', payment_type: :per_item).save!
pm = PricingModel.new(pricing_strategy: :per_item, amount_cents: 20_00)
pm.save!
client = Client.new(pricing_model: pm, name: 'Dave')
client.save!
st = StorageObject.new(client: client, name: 'Faker::House.furniture', price: 332)
st.save!
