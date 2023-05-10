Rails.application.routes.draw do
  resources :games, except: %i(show), shallow: true do
    resources :resources, except: %i(show)
    resources :resource_groups, except: %i(show)
    resources :dice, shallow: true, except: %i(show) do
      resources :faces, shallow: true, except: %i(show)
    end
    resources :rooms, shallow: true, except: %i(index) do
      resources :room_resources, except: %i(new create delete)
      resources :rolls, only: %i(index new create)
    end
  end
  devise_for :users

  get "/rooms/join/:join_code", to: "join_room#find_room", as: "find_room"
  post "/rooms/join/:join_code", to: "join_room#join_room", as: "join_room"

  get "/rooms/:room_id/play", to: "play#index", as: "room_play"

  root to: "home#index"
end
