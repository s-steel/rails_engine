Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants
      resources :items
      scope :merchants do
        get '/:id/items', to: 'merchants/items#index', as: :merchant_items
      end
    end
  end
end
