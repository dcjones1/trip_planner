Rails.application.routes.draw do
  resources :grounds
  resources :flights
  resources :trips
  resources :users
  root to: "site#home"
  get '/search' => "site#search"
  get '/application/airports', to: "application#airports", as: :airports
  post '/flights/:id/add_to_cart' => "flights#add_to_cart"

end
