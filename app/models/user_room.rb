class UserRoom < ApplicationRecord
  belongs_to :room
  belongs_to :user

  after_create :sync_resources

  def sync_resources
    # TODO: add test
    resources = Resource.where(game: room.game)
    resources.each do |resource|
      RoomResource.find_or_create_by(
        room: room,
        user: user,
        resource: resource
      )
    end
  end

  def resources_by_group
    group_map = {}
    room_resources.each do |room_resource|
      if group_map.key? room_resource.resource.group_name
        group_map[room_resource.resource.group_name].push room_resource
      else
        group_map[room_resource.resource.group_name] = [room_resource]
      end
    end
    group_map
  end

  def room_resources
    RoomResource.where(user: user, room: room)
  end
end
