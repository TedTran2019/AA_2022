Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
  end
  resources :artworks, only: [:show, :create, :update, :destroy] do
    resources :comments, only: [:index]
  end
  resources :artwork_shares, only: [:create, :destroy]
  resources :comments, only: [:index, :create, :destroy]
end
