Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i(index)
      resources :learning_resources, only: %i(index)
      resources :users, only: %i(create)
      resources :favorites, only: %i(create)
    end
  end
end
