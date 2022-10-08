Rails.application.routes.draw do
  devise_for :users
  
  root "contents#index"

  resources :contents, only: [:index, :new, :create, :show, :edit, :update] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: :show do
    resource :follow_relations, only: [:create, :destroy]
    get 'followings' => 'follow_relations#followings', as: 'followings'
    get 'followers' => 'follow_relations#followers', as: 'followers'

    resources :recommends, only: [:new, :create]
  end
  resources :recommends, only: :destroy
end