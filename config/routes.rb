Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#find'
      get 'merchants/find_all', to: 'merchants#find_all'
      get 'items/find', to: 'items#find'
      get 'items/find_all', to: 'items#find_all'
      resources :merchants do
        resources :items, only: [:index]
      end
      resources :items do
        resources :merchants, only: [:index]
      end
    end
  end
end
