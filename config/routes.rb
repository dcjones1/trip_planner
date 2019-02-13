Rails.application.routes.draw do
  root to: 'site#home'
  get '/search' => 'site#search'
  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :flights
  resources :trips
  resources :users
end
