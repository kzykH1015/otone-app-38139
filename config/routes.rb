Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    get "spoilers", to: "users/registrations#new_spoiler"
    post "spoilers", to: "users/registrations#create_spoiler"
  end
  
  root "contents#index"

  resources :contents, only: [:index, :new, :create, :show, :edit, :update] do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search_genre'
      get 'search_creator'
      get 'search_content'
    end
  end
  resources :users, only: :show do
    resource :follow_relations, only: [:create, :destroy]
    get 'followings' => 'follow_relations#followings', as: 'followings'
    get 'followers' => 'follow_relations#followers', as: 'followers'

    resources :recommends, only: [:new, :create]
  end
  
  resources :recommends, only: :destroy
  resources :comments, only: :destroy
end