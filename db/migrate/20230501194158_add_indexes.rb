class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :faces, [:name, :die_id], unique: true
    add_index :resource_groups, [:name, :game_id], unique: true
    add_index :rooms, [:name, :created_by_id], unique: true
    add_index :games, [:name, :created_by_id], unique: true
  end
end
