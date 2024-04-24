Rails.application.routes.draw do
  devise_for :buffet_owners, path: 'buffet_owners'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :buffets, only: [:new, :create, :edit, :update, :show] do
    get 'search', on: :collection
  end

  resources :events, only: [:new, :create, :edit, :update, :show] do
    resources :base_prices, only: [:new, :create]
  end

  resources :base_prices, only: [:show, :edit, :update]

  get 'owner/dashboard', to: 'buffet_owner_dashboard#index'

  # Defines the root path route ("/")
  root "home#index"
end
