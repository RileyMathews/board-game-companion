class Roll < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :roll_results, dependent: :destroy

  scope :for_room_log, ->(room) { where(room: room).order(created_at: :desc).includes(:user, roll_results: :face) }

  def summary
    roll_results.map { |result| result.face.name }.tally
  end

  def summary_string
    summary_map = summary
    rolls = summary_map.map { |face, count| "#{face}: #{count}" }.join(" | ")
    "#{user.username} rolled #{rolls}"
  end

  def broadcast_roll
    broadcast_append_to "room-#{room.id}", partial: "play/roll", locals: { roll: self }, target: "rolls"
    broadcast_prepend_to "room_#{room.id}_rolls"
  end
end
