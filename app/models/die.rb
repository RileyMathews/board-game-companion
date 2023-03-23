class Die < ApplicationRecord
  belongs_to :game
  belongs_to :created_by, class_name: "User"
  has_many :faces

  validates :name, presence: true
end
