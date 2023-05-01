class ResourceGroup < ApplicationRecord
  belongs_to :game
  has_many :resources, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :game_id }
end
