Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]
      get 'merchants/:id/items', to: 'merchant_items#index'
      get 'items/:id/merchant', to: 'item_merchants#index'
      get 'revenue/merchants/:id', to: 'revenue#merchant_revenue'
      get 'revenue/unshipped', to: 'revenue#potential_revenue'
    end
  end
end
