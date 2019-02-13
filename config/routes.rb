Rails.application.routes.draw do
  resources :grounds
  resources :flights
  resources :trips
  resources :users
  root to: "site#home"
  get '/search' => "site#search"
  post '/flights/:id/add_to_cart' => "flights#add_to_cart"

end
