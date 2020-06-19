Rails.application.routes.draw do
  get "/", to: "sessions#new"
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  get "/home", to: "home#index"
  get "/yourorder", to: "orders#your_orders"
  post "viewcart", to: "orders#view"
  get "/clerks", to: "clerks#index"
  get "/new_clerk", to: "clerks#new"
  resources :users
  resources :orders
  resources :order_items
  resources :menus
  resources :menu_items
  resources :carts
end
