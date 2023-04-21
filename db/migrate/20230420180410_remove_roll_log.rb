class RemoveRollLog < ActiveRecord::Migration[7.0]
  def change
    add_reference :rolls, :user, foreign_key: true
    add_reference :rolls, :room, foreign_key: true

    Roll.find_each do |roll|
      roll.update! user: roll.roll_log.user_room.user, room: roll.roll_log.user_room.room
    end

    remove_column :rolls, :roll_log_id
    drop_table :roll_logs
  end
end
