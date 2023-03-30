class RollResult < ApplicationRecord
  belongs_to :face
  belongs_to :user
  belongs_to :room
end
