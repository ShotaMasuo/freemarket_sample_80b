Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: :show do
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
end
