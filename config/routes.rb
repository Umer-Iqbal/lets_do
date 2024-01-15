Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts do
    member do
      post :like
    end
    resources :comments
  end

  resources :users do
    member do
      post :profile_images_edit
      get :search_user
      get :notifications
    end
    collection do
      get :add_friend
    end
  end

  resource :friendships do

  end

  resources :messages
  resources :conversations, only: [:index] do
    get :load_conversation, on: :collection
  end
end
