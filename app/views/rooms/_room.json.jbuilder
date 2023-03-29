json.extract! room, :id, :game_id, :name, :created_by_id, :created_at, :updated_at
json.url room_url(room, format: :json)
