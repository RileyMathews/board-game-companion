class UserRoom < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :user, uniqueness: { scope: :room_id }

  after_create -> { room.sync_all_resources }

  def sync_resources
    room.sync_all_resources
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
