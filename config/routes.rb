Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'wellcome#index'

  namespace :api, defaults: { format: :json } do
    resources :payment_models, only: %i(index)
    # put '/card', to: 'cards#update'

    namespace :admin do
      resources :clients, only: %i(index), path: 'stock'
      resources :finances, only: %i(index)

      #invoicing
    end
  end
end
# A)
#   PaymentModel.new(type: 'per_item_fee', amount: 20, currency: 'usd')
#   Discount.new(type: 'fixed', amount: 10, amount_type: 'persantage')
#   Client.new(payment_model: pm, discounts: [discount])
# B)
#   PaymentModel.new(type: 'per_square_foot', amount: 1, currency: 'usd')
# C)
#   PaymentModel.new(type: 'per_item_value', amount: 10, amount_type: 'persantage')
# D)
#   PaymentModel.new(type: 'per_square_foot', amount: 2, currency: 'usd')
#   Discount.new(type: 'storage_object_inclusion', amount: 5, amount_type: 'persantage', quantitly_type: 'inclusion', quantity: 1, quantity: 100) # first 100
#   Discount.new(type: 'items_range', amount: 10, amount_type: 'persantage', quantitly_type: 'inclusion', quantity: 101,  quantity: 200) # first 100 more than or less then?s
#   Discount.new(type: 'items_range', amount: 15, amount_type: 'persantage', quantitly_type: 'inclusion_more_than', quantity: 200) # if static 
#   # lets try make dynamic here

# Bonus)
#   Discount.new(type: 'month_bill', amount: 200, amount_type: 'cash', quantitly_type: 'eqal', quantity: 400)

# PaymentModel
#   type: 'per_item_fee per_item_value per_square_foot'
#   value: 10
#   currency: '$' ?
#   name:

# Discount
#   name: ''
#   status: 'active'
#   type: 'flat items_count month_bill'
#   value: 15
#   value_persentage_or_dolar:
#   quantitly_type: 'progressice(count) eqal more_than' #quiantity consitoin or rule
#   type_of: 'more_than less_than'
#   type_of_value: 150 400
#   type_of_value_more_than: 400
#   overal_or_for_one_client:

# ClientDiscounts
#   discount_id:
#   client_id:

# Client
#   name:

# PlacementOrStorageOrder
#   status: 'active closed'
#   date:
#   client_id:
#   payment_model_id:

# storage object
#   description: 'Sofa'
#   storeage_order_id:
#   status: 'active '
#   weight:
#   sqare_size:
#   expected_price:

