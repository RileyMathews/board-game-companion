class Die < ApplicationRecord
  belongs_to :game
  has_many :faces, dependent: :destroy
end
