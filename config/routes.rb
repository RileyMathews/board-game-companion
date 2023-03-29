Rails.application.routes.draw do
  resources :games, except: %i(show), shallow: true do
    resources :dice
  end
  devise_for :users
  root to: "home#index"
end
