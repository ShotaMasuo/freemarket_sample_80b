Rails.application.routes.draw do
  
  root 'items#index'

  resources :credit_cards, only: [:new, :create, :show, :destroy]

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    member do
      get 'point', to: "items#point"
      post 'confirmation', to: "items#confirmation"
      get 'pay', to: "items#pay"
      post 'favorite', to: "favorites#create"
      post 'comment', to: "comments#create"
      post 'deleteimage', to: "items#image_destroy"
    end
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
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
  get 'tradeitem', to: "users#tradeitem"
  get 'solditem', to: "users#solditem"
  get 'favorites', to: "users#favorites"
  get 'history', to: "users#history"
  get 'point', to: "users#point"
  get 'profile', to: "users#profile"
  get 'logoutbtn', to: "users#logoutbtn"

end
