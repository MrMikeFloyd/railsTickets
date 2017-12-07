Rails.application.routes.draw do

  # Dynamic resources
  resources :users
  resources :documents
  resources :pictures
  resources :claim_statuses
  resources :claim_types
  resources :claims
  resources :solutions

  # Static resources
  root   'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'

  # Session handling and registation
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

end