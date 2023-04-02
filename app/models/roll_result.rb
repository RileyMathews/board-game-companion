class RollResult < ApplicationRecord
  belongs_to :roll_log
  belongs_to :face
end
