Rails.application.routes.draw do
  resources :transits
  resources :trips
  resources :carts
  resources :users

  get '/options' => "transits#options"
end
