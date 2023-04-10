class ChangeRollLog < ActiveRecord::Migration[7.0]
  def change
    remove_column :roll_logs, :room_id, :bigint
    remove_column :roll_logs, :user_id, :bigint
    add_reference :roll_logs, :user_room, null: false, foreign_key: true
  end
end
