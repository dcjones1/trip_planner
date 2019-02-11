Rails.application.routes.draw do
  resources :flights
  resources :trips
  resources :users

  get '/search' => "site#search" 
end
