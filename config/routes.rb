Rails.application.routes.draw do
  get "/", to: "sessions#new"
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  resources :users
  resources :orders
  resources :order_items
  resources :menus
  resources :menu_items
  resources :carts
end
