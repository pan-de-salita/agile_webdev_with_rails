Rails.application.routes.draw do
  root to: 'store#index', as: 'store_index'

  resources :line_items
  resources :carts
  resources :products
end
