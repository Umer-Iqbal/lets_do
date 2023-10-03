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
    end
  end
end
