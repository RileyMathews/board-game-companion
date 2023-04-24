class Roll < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :roll_results, dependent: :destroy

  def summary
    roll_results.joins(:face).group("faces.name").count
  end

  def summary_string
    summary_map = summary
    rolls = summary_map.map { |face, count| "#{face}: #{count}" }.join(" | ")
    "#{user.username} rolled #{rolls}"
  end

  def broadcast_roll
    broadcast_append_to "room-#{room.id}", partial: "play/roll", locals: { roll: self }, target: "rolls"
  end
end
