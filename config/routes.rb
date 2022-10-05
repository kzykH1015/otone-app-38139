Rails.application.routes.draw do
  devise_for :users
  
  root "contents#index"

  resources :contents, only: [:index, :new, :create, :show, :edit, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: :show
end