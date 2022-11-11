Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i(index)
      resources :learning_resources, only: %i(index)
    end
  end
end
