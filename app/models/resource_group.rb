class ResourceGroup < ApplicationRecord
  belongs_to :game
  has_many :resources, dependent: :nullify
end
