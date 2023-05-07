Rails.application.routes.draw do
  resources :games, except: %i(show), shallow: true do
    resources :resources, except: %i(show)
    resources :resource_groups, except: %i(show)
    resources :dice, shallow: true, except: %i(show) do
      resources :faces, shallow: true, except: %i(show)
    end
    resources :rooms, shallow: true, except: %i(index)
  end
  devise_for :users

  get "/rooms/join/:join_code", to: "join_room#find_room", as: "find_room"
  post "/rooms/join/:join_code", to: "join_room#join_room", as: "join_room"

  get "/rooms/:room_id/play", to: "play#index", as: "room_play"
  post "/rooms/:room_id/roll/:die_id/:number", to: "play#roll", as: "roll_dice"
  post "/rooms/:room_id/archive_rolls", to: "play#archive_rolls", as: "archive_rolls"
  post "/play/rolls/:roll_id/archive", to: "play#archive_roll", as: "archive_roll"

  post "/room_resources/:id/increment", to: "room_resources#increment", as: "increment_room_resource"
  post "/room_resources/:id/decrement", to: "room_resources#decrement", as: "decrement_room_resource"

  root to: "home#index"
end
