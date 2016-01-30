Rails.application.routes.draw do
  resources :users
  root to: 'application#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  get '/about' => 'application#about'
  get '/tasks/:id/priority' => 'tasks#edit_priority', as: 'edit_task_priority'
  get '/tasks/:id/description' => 'tasks#edit_description', as: 'edit_task_description'
  patch '/admin/:id' => 'admin#change_admin_priveledges'
  get '/admin' => 'admin#home'
  resources :users, only: [:create, :update, :new]
  resources :lists, only: [:create, :destroy]
  resources :tasks, only: [:create, :destroy, :update]
  resources :stars, only: [:create, :destroy]
end
