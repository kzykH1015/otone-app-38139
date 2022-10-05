Rails.application.routes.draw do
  devise_for :users
  
  root "contents#index"

  resources :contents, only: [:index, :new, :create, :show, :edit, :update]
  resources :users, only: :show
  resources :likes, only: [:new, :create, :delete]
end