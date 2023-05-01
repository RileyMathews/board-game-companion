class Resource < ApplicationRecord
  belongs_to :game
  belongs_to :resource_group, optional: true
  has_many :room_resources, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :game_id }

  after_create :sync_resources

  def sync_resources
    active_rooms = UserRoom.joins(room: :game).where(games: { id: game.id })
    active_rooms.each(&:sync_resources)
  end

  def group_name
    resource_group&.name || "Ungrouped"
  end
end
