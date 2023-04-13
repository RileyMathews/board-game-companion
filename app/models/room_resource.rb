class RoomResource < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :resource
  belongs_to :room
end
