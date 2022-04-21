Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cats, only: %i[index show create update new edit]
  resources :cat_rental_requests, only: %i[new create] do
    member do
      get 'approve'
      get 'deny'
    end
  end

  root to: 'cats#index'
end
