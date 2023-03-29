Rails.application.routes.draw do
  resources :games, except: %i(show), shallow: true do
    resources :dice, shallow: true do
      resources :faces, shallow: true
    end
  end
  devise_for :users
  root to: "home#index"
end
