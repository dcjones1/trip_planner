Rails.application.routes.draw do
  root to: 'static#home'
  get '/search' => 'static#search'
  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/flights/:id/add_to_cart' => "flights#add_to_cart"

  resources :users
  resources :grounds
  resources :flights
  resources :trips do
    collection do
      get 'airports', to: 'trips#airports'
      post 'airports', to: 'flights#new'
    end
  end
end
