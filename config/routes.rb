Rails.application.routes.draw do
  resources :users
  root to: 'application#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  get '/about' => 'application#about'
  resources :users, only: [:create, :update, :new]
  resources :lists, only: [:create, :destroy]
  resources :tasks, only: [:create, :destroy]
  resources :stars, only: [:create, :destroy]
end
