Rails.application.routes.draw do
  resources :flights
  resources :trips
  resources :users
  root to: "site#home"
  get '/search' => "site#search"
end
