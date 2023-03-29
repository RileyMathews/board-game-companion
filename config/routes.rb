Rails.application.routes.draw do
  resources :games, except: %i(show)
  devise_for :users
  root to: "home#index"
end
