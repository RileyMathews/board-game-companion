class UserRoom < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :user_room_resources, dependent: :destroy
  has_many :resources, through: :user_room_resource

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
end
