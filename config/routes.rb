Rails.application.routes.draw do
  root to: 'customers#index'
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get  '/customers/:customer_id/orders', to: 'orders#index', as: 'customer_orders'
  # post '/customers/:customer_id/orders', to: 'orders#create'
  # get '/customers/:customer_id/orders/new', to: 'orders#new', as: 'new_order'
  # get '/customers/:customer_id/orders/:id', to: 'orders#show', as: 'customer_order'
  # get '/customers/:customer_id/orders/:id/edit', to: 'orders#edit', as: 'edit_order'
  # patch '/customers/:customer_id/orders/:id/edit', to: 'orders#update'
  # delete '/customers/:customer_id/orders/:id', to: 'orders#destroy'

  get  '/orders', to: 'orders#index', as: 'orders'
  post '/orders', to: 'orders#create'
  get '/orders/new', to: 'orders#new', as: 'new_order'
  get '/orders/:id', to: 'orders#show', as: 'order'
  get '/orders/:id/edit', to: 'orders#edit', as: 'edit_order'
  patch '/orders/:id', to: 'orders#update'
  delete '/orders/:id', to: 'orders#destroy'
end
