class Die < ApplicationRecord
  self.table_name = "dice"
  belongs_to :game
  belongs_to :created_by, class_name: "User"

  validates :name, presence: true
end
