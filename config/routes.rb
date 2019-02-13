Rails.application.routes.draw do
  resources :grounds
  resources :flights
  resources :trips
  resources :users
  root to: "site#home"
  get '/search' => "site#search"
  get '/grounds/:id/airport', to: "grounds#airport"
  post '/grounds/airports', to: "grounds#airports", as: :airport_options
  post '/flights/:id/add_to_cart' => "flights#add_to_cart"

end
