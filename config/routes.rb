Rails.application.routes.draw do
  resources :credit_cards, only: [:new, :create]
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:show, :new, :edit, :update] do
    member do
      get 'confirmation', to: "items#confirmation"
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
  get 'saleitem', to: "users#saleitem"
  get 'favorites', to: "users#favorites"
  get 'history', to: "users#history"
  get 'point', to: "users#point"
  get 'profile', to: "users#profile"
  get 'logoutbtn', to: "users#logoutbtn"
end
