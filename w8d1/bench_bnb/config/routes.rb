Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    resource :user, only: %i[create]
    resource :session, only: %i[create destroy]
    resources :benches, only: %i[index create]
  end

  root 'static_pages#root'
  get '*path', to: 'static_pages#root'
end
