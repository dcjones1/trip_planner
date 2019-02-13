Rails.application.routes.draw do
  resources :grounds
  resources :flights
  resources :trips do
    collection do
      get 'airports', to: 'trips#airports'
      post 'airports', to: 'trips#options'
    end
  end
  resources :users
  root to: "site#home"
  get '/search' => "site#search"
  # get '/airports' => "site#airports"
  # post '/options' => "site#options"
  post '/flights/:id/add_to_cart' => "flights#add_to_cart"
  # resources :trips collection: {:airports => :get, :options => :post}

end
