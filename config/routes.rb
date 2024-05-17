Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :clients, path: 'clients'
  devise_for :buffet_owners, path: 'buffet_owners'

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:index, :show] do
        get 'search', on: :collection
        resources :events, only: [:index]
      end

      resources :events, only: [:index] do
        get 'available', on: :member
      end
    end
  end

  resources :buffets, only: [:new, :create, :edit, :update, :show] do
    get 'search', on: :collection
    get 'orders', on: :member
    post 'deactivate', on: :member
    post 'activate', on: :member
    resources :sales, only: [:index]
  end

  resources :events, only: [:new, :create, :edit, :update, :show] do
    resources :orders, only: [:new, :create]
    resources :base_prices, only: [:new, :create]
    post 'deactivate', on: :member
    post 'activate', on: :member
  end

  resources :base_prices, only: [:show, :edit, :update]

  resources :orders, only: [:show, :edit, :update, :index] do
    resources :order_payments, only: [:create, :update]
    resources :messages, only: [:create]
    post 'confirmed', on: :member
    post 'canceled', on: :member
  end

  resources :order_evaluations, only: [:create, :index]

  resources :sales, only: [:new, :create]

  get 'owner/dashboard', to: 'buffet_owner_dashboard#index'

  root "home#index"
end
