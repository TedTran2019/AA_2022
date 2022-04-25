Rails.application.routes.draw do
  resources :comments
  resources :goals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: %i[new create show index]
  resource :session, only: %i[new create destroy]
  resources :goals
  resources :comments, only: %i[create]
  root 'users#index'
end
