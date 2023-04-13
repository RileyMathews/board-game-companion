class RemoveUserRooms < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_room_resources
    create_table :room_resources do |t|
      t.references :room, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.integer :ammount, null: false, default: 0
    end

    add_index :room_resources, [:room_id, :resource_id, :user_id], unique: true
  end
end
