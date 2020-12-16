Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants do
        resources :items, only: [:index]
      end
      resources :items do
        resources :merchants, only: [:index]
      end

      get 'merchants/find?:attribute=:value', to: 'merchants#find'
    end
  end
end
