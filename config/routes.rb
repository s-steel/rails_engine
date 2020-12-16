Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :items do
        get '/find', to: 'items/search#show'
        get '/find_all', to: 'items/search#index'
      end
      scope :merchants do
        get '/find', to: 'merchants/search#show'
        get '/find_all', to: 'merchants/search#index'
        get '/most_revenue', to: 'merchants/revenue#index'
      end
      resources :merchants do
        get '/revenue', to: 'merchants/revenue#show'
        resources :items, only: [:index]
      end
      resources :items do
        resources :merchants, only: [:index]
      end
    end
  end
end
