Rails.application.routes.draw do
  resources :users
  root to: 'sessions#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  get '/about' => 'application#about'
  resources :users
  resources :lists, only: [:create, :destroy]
  resources :tasks, only: [:create, :destroy]
end
