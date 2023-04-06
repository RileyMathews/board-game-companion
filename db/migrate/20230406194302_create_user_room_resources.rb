class CreateUserRoomResources < ActiveRecord::Migration[7.0]
  def change
    create_table :user_room_resources do |t|
      t.references :user_room, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.integer :ammount, null: false, default: 0

      t.timestamps
    end

    add_index :user_room_resources, [:user_room_id, :resource_id], unique: true
  end
end
