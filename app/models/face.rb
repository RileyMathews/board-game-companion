class Face < ApplicationRecord
  belongs_to :die
  has_many :roll_results, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :die_id }
end
