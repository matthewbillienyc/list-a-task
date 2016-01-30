Rails.application.routes.draw do
  root to: 'application#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  get '/about' => 'application#about'
  get '/tasks/:id/priority' => 'tasks#edit_priority', as: 'edit_task_priority'
  get '/tasks/:id/description' => 'tasks#edit_description', as: 'edit_task_description'
  get '/admin' => 'admin#home'
  post '/login_as/:id' => 'admin#log_in_as', as: 'login_as'
  resources :users, only: [:new, :create, :update, :show]
  resources :lists, only: [:create, :destroy]
  resources :tasks, only: [:create, :destroy, :update]
  resources :stars, only: [:create, :destroy]
end
