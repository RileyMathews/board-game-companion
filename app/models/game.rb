class Game < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  has_many :dice, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
end
