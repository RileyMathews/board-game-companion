Rails.application.routes.draw do
  resources :games do
    resources :rooms
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resource :users

  # Defines the root path route ("/")
  # root "articles#index"
end
