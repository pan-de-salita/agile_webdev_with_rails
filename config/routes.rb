Rails.application.routes.draw do
  resources :users
  resources :orders
  root to: 'store#index', as: 'store_index'

  post 'search', to: 'store#index', as: 'search'

  resources :line_items
  resources :carts
  resources :products
end
