Rails.application.routes.draw do
  resources :users
  resources :orders
  resources :order_items
  resources :menus
  resources :menu_items
  resources :carts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
