class RoomResource < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :resource
  belongs_to :room

  after_save :broadcast_update

  def broadcast_update
    broadcast_replace_to "room-#{room.id}", partial: "play/resource", locals: { resource: self }, target: "read-resource-#{id}"
  end
end
