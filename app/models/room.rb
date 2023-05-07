class Room < ApplicationRecord
  belongs_to :game
  belongs_to :created_by, class_name: "User"
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :room_resources, dependent: :destroy
  has_many :resources, through: :room_resources
  has_many :rolls, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :created_by_id }

  after_create :just_created

  def sync_all_resources
    sync_global_resources
    sync_player_resources
  end

  def grouped_resources_for_player(user:)
    {
      global: RoomResource.where(user: nil, room: self).group_by(&:group_name),
      player: RoomResource.where(user: user, room: self).group_by(&:group_name)
    }
  end

private

  def just_created
    users << created_by
    sync_all_resources
  end

  def sync_global_resources
    global_resources = Resource.where(global: true, game: game)
    global_resources.each do |resource|
      RoomResource.find_or_create_by(
        user: nil,
        room: self,
        resource: resource
      )
    end
  end

  def sync_player_resources
    player_resources = Resource.where(global: false, game: game)
    user_rooms.reload.each do |user_room|
      player_resources.each do |resource|
        RoomResource.find_or_create_by(
          user: user_room.user,
          room: self,
          resource: resource
        )
      end
    end
  end
end
