class Room < ApplicationRecord
  belongs_to :game
  belongs_to :created_by, class_name: "User"
  has_many :roll_esults, dependent: :destroy
end
