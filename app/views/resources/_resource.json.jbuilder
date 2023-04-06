json.extract! resource, :id, :game_id, :name, :min, :max, :created_at, :updated_at
json.url resource_url(resource, format: :json)
