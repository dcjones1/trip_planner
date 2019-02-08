Rails.application.routes.draw do
  resources :transits
  resources :trips
  resources :carts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
