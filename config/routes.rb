Rails.application.routes.draw do

  # Dynamic resources
  resources :users
  resources :documents,       only: [:new, :create, :destroy]
  resources :pictures,        only: [:show, :new, :create, :destroy]
  resources :solutions,       only: [:show, :new, :create, :destroy]
  resources :investigations,  only: [:show, :new, :create, :destroy]
  resources :claims do
    member do
      get 'finish' # Claim-Abschluss
      get 'reopen' # Claim-Wiedereröffnung
    end
  end

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