class Room < ApplicationRecord
  belongs_to :game
  belongs_to :created_by, class_name: "User"
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :room_resources, dependent: :destroy
  has_many :resources, through: :room_resources

  after_create :just_created

private

  def just_created
    users << created_by
  end
end
