Rails.application.routes.draw do
  resources :users do
    post :transaction, on: :member
  end

  namespace :api do
    resources :wallets, only: [] do
      member do
        get :balance
        get :transactions
        post :transaction
      end
    end
  end

  root "users#index"
end