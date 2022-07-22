Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    resource :user, only: %i[create]
    resource :session, only: %i[create destroy]
  end

  root 'static_pages#root'
  get '*path', to: 'static_pages#root'
end
