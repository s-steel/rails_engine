Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#find'
      resources :merchants do
        resources :items, only: [:index]
      end
      resources :items do
        resources :merchants, only: [:index]
      end
    end
  end
end
