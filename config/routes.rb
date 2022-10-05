Rails.application.routes.draw do
  get 'follow_relations/followings'
  get 'follow_relations/followers'
  devise_for :users
  
  root "contents#index"

  resources :contents, only: [:index, :new, :create, :show, :edit, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: :show do
    resource :follow_relations, only: [:create, :destroy]
    get 'followings' => 'follow_relations#followings', as: 'followings'
    get 'followers' => 'follow_relations#followers', as: 'followers'
  end
end