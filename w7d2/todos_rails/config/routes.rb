Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do 
    resources :todos, only: %i[index show create update destroy], defaults: { format: :json }
  end
  # root 'frontend#index'
  root 'static_pages#root'
end
