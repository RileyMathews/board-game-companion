class AddJoinCodeToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :join_code, :uuid, default: "gen_random_uuid()", null: false
    add_index :rooms, :join_code, unique: true
  end
end
