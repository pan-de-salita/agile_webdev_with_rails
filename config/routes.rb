Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
  root to: 'store#index', as: 'store_index'

  # post 'search', to: 'store#index', as: 'search'

  resources :line_items
  resources :carts
  resources :products do
    get :who_bought, on: :member
  end
end
