Rails.application.routes.draw do
  resources :posts
  resources :subs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: %i[new create show]
  resource :session, only: %i[new create destroy]

  resources :subs
  resources :posts, except: %i[index] do
    resources :comments, only: %i[new]
  end
  resources :comments, only: %i[create show]

  root 'subs#index'
end
