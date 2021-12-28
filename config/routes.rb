Rails.application.routes.draw do
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
    end
  end
  
  namespace :storefront do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories, only: :index
      resources :products, only: [:index, :show]
      resources :wish_items, only: [:index, :create, :destroy]
      post "/coupons/:coupon_code/validations", to: "coupon_validations#create"
    end
  end
end
