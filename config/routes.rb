Rails.application.routes.draw do
  get 'user_sessions/new'
  get 'user_sessions/create'
#  get 'users/index'
#   get 'users/new'
#   get 'users/create' 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'users#new'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new,  :block, :unblock, :delete, :create]


  get '/login' => 'user_sessions#new'
  post '/login' => 'user_sessions#create'
  delete '/logout' => 'user_sessions#destroy'
  get '/logout' => 'user_sessions#destroy'


  delete '/users/delete', to: 'users#delete'
  put '/users/delete', to: 'users#delete'

  put '/users/block', to: 'users#block'
  delete '/users/block', to: 'users#block'

  put '/users/unblock', to: 'users#unblock'
  delete '/users/unblock', to: 'users#unblock'

  


end
