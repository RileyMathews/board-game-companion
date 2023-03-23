Rails.application.routes.draw do
  resources :games, shallow: true do
    resources :rooms
    resources :dice do
      resources :faces, shallow: false
    end
  end
  devise_for :users
  root to: "home#index"
end
