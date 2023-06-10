class RoomResource < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :resource
  belongs_to :room

  validates :resource, uniqueness: { scope: %i(user_id room_id) }

  after_save :broadcast_update

  scope :other_players, ->(room, active_user) { where(room: room).where.not(user: active_user).joins(:user) }

  delegate :group_name, to: :resource
end
