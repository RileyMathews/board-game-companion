Rails.application.routes.draw do
  resources :games, except: %i(show), shallow: true do
    resources :resources
    resources :dice, shallow: true do
      resources :faces, shallow: true
    end
    resources :rooms, shallow: true
  end
  resources :user_room_resources, only: %i(update)
  devise_for :users

  get "/rooms/join/:join_code", to: "join_room#find_room", as: "find_room"
  post "/rooms/join/:join_code", to: "join_room#join_room", as: "join_room"

  get "/rooms/:room_id/play", to: "play#index", as: "room_play"
  post "/rooms/:room_id/roll/:die_id/:number", to: "play#roll", as: "roll_dice"
  post "/rooms/:room_id/archive_rolls", to: "play#archive_rolls", as: "archive_rolls"

  root to: "home#index"
end
