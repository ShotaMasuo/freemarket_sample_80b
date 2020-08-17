Rails.application.routes.draw do
  resources :credit_cards, only: [:new, :create, :show, :destroy]
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:show, :new] do
    member do
      get 'confirmation', to: "items#confirmation"
      post 'pay', to: "items#pay"
    end
  end
  resources :categories, only: [:index, :show] do
    member do
      get 'brand', to: "categories#brand"
    end
    collection do
      get 'brand', to: "categories#brandIndex"
    end
  end
  resources :users, only: [:index, :show]

end
