Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :promotions do
    member do
      post 'generate_coupons'
      post 'approve'  
    end
  end

  resources :coupons , only: [] do
    post 'disable', on: :member
  end
end
