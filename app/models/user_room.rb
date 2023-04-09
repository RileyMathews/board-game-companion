class UserRoom < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :user_room_resources, dependent: :destroy
  has_many :resources, through: :user_room_resources

  after_create :sync_resources

  def sync_resources
    # TODO: add test
    resources = Resource.where(game: room.game)
    resources.each do |resource|
      UserRoomResource.find_or_create_by(
        user_room: self,
        resource: resource
      )
    end
  end

  def current_resources
    user_room_resources
  end

  def resources_by_group
    group_map = {}
    user_room_resources.each do |user_room_resource|
      if group_map.key? user_room_resource.resource.group_name
        group_map[user_room_resource.resource.group_name].push user_room_resource
      else
        group_map[user_room_resource.resource.group_name] = [user_room_resource]
      end
    end
    group_map
  end
end
