require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # Configure Sidekiq-specific session middleware
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"
  EcommerceApi::Application.routes.draw do
    mount Sidekiq::Web => "/sidekiq"
  end
  
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'
  mount LetterOpenerWeb::Engine, at: "/emails" if Rails.env.development?
  
  namespace :admin, defaults: { format: :json } do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories
      resources :coupons
      resources :system_requirements
      resources :products
      resources :games, only: [], shallow: true do
        resources :licenses
      end
      resources :users
      resources :orders, only: [:index, :show]
      namespace :dashboard do
        resources :summaries, only: :index
      end
    end
  end
  
  namespace :storefront do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories, only: :index
      resources :products, only: [:index, :show]
      resources :wish_items, only: [:index, :create, :destroy]
      post "/coupons/:coupon_code/validations", to: "coupon_validations#create"
      resources :checkouts, only: :create
      resources :orders, only: [:index, :show]
      resources :games, only: :index
    end
  end

  namespace :juno do
    namespace :v1 do
      resources :payment_confirmations, only: :create
    end
  end
end
