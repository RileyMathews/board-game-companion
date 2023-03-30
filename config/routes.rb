Rails.application.routes.draw do
  resources :games, except: %i(show), shallow: true do
    resources :dice, shallow: true do
      resources :faces, shallow: true
    end
    resources :rooms, shallow: true
  end
  devise_for :users

  get "/rooms/:room_id/play", to: "play#index"
  get "/rooms/:room_id/roll/:die_id/:number", to: "play#roll", as: "roll_dice"

  root to: "home#index"
end
