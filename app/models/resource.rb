class Resource < ApplicationRecord
  belongs_to :game
  has_many :user_room_resources, dependent: :destroy
  has_many :user_rooms, through: :user_room_resources

  after_create :sync_resources

  def sync_resources
    active_rooms = UserRoom.joins(room: :game).where(games: { id: game.id })
    active_rooms.each(&:sync_resources)
  end
end
