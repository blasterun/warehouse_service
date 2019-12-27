Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :pricing_models
    resources :discounts

    resources :clients do
      resources :discounts, only: %i(index create destroy), module: 'clients'
      resources :invoices, only: %i(index), module: 'clients'
      resources :storage_object, module: 'clients'
    end
  end
end
