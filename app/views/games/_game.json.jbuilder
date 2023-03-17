json.extract! game, :id, :name, :uuid, :slug, :created_by_id, :created_at, :updated_at
json.url game_url(game, format: :json)
