class UserRoomResource < ApplicationRecord
  belongs_to :user_room
  belongs_to :resource
end
