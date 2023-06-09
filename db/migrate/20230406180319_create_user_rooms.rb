class CreateUserRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :user_rooms do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_rooms, [:user_id, :room_id], unique: true
  end
end
